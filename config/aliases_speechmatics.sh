HOST_IP_ADDR=$(hostname -I | awk '{ print $1 }') # This gets the actual ip addr

# Quick navigation add more here
alias a="cd ~/git/aladdin"
alias cde="cd /exp/$(whoami)"

# Change to aladdin directory and activate SIF
alias msa="make -C /home/$(whoami)/git/aladdin/ shell"

# Activate aladdin SIF in current directory
alias msad="/home/$(whoami)/git/aladdin/env/singularity.sh -c "$SHELL""

# Misc
alias jp="jupyter lab --no-browser --ip $HOST_IP_ADDR --NotebookApp.token='123' --NotebookApp.password='123'"
alias ls='ls -hF --color' # add colors for filetype recognition
alias nv='nvidia-smi'

# make file
alias m='make'
alias mc="make check"
alias ms='make shell'
alias mf="make format"
alias mtest="make test"
alias mft="make functest"
alias mut="make unittest"

### Tensorboard

alias tb="tensorboard --host=$HOST_IP_ADDR --reload_multifile true --logdir=."
tblink () {
  # Creates symlinks from specified folders to ~/tb/x where x is an incrmenting number
  # and launches tensorboard
  # example: `tblink ./lm/20210824 ./lm/20210824_ablation ./lm/20210825_updated_data`
  if [ "$#" -eq 0 ]; then
    logdir=$(pwd)
  else
  # setup tensorboard directory
    tbdir="$HOME/tb"
    if [ -d "$tbdir" ]; then
      last="$(printf '%s\n' $tbdir/* | sed 's/.*\///' | sort -g -r | head -n 1)"
      new=$((last+1))
      echo "last folder $last, new folder $new"
      logdir="$tbdir/$new"
    else
      logdir="$tbdir/0"
    fi
    # softlink into tensorboard directory
    for linkdir in "$@"; do
      linkdir=$(rl $linkdir)
      if [ ! -d $linkdir ]; then
          echo "linkdir $linkdir does not exist"
          return
      fi
      echo "linkdir: $linkdir"
      mkdir -p $logdir
      ln -s $linkdir $logdir
    done
  fi
  echo "logdir: $logdir"
  singularity exec "$TENSOR_BOARD_SIF" tensorboard --host=$HOST_IP_ADDR --reload_multifile true --logdir=$logdir
}

tbadd() {
  # Add experiment folder to existing tensorboard directory (see tblink)
  # example: `tbadd ./lm/20210825 25` will symlink ./lm/20210824 to ~/tb/25
  if [ "$#" -eq 2 ]; then
    tbdir="$HOME/tb"
    linkdir=$(rl $1)
    logdir=$tbdir/$2
    ln -s $linkdir $logdir
    echo "linkdir: $linkdir"
    echo "logdir: $logdir"
  else
    echo "tbadd <exp_dir> <tb number>"
  fi
}

### Queue management

# Short aliases
full_queue='qstat -q "aml*.q@*" -f -u \*'
alias q='qstat'
alias qtop='qalter -p 1024'
alias qq=$full_queue # Display full queue
alias gq='qstat -q aml-gpu.q -f -u \*' # Display just the gpu queues
alias gqf='qstat -q aml-gpu.q -u \* -r -F gpu | egrep -v "jobname|Master|Binding|Hard|Soft|Requested|Granted"' # Display the gpu queues, including showing the preemption state of each job
alias cq='qstat -q "aml-cpu.q@gpu*" -f -u \*' # Display just the cpu queues
alias wq="watch qstat"
alias wqq="watch $full_queue"

# Queue functions
qlogin () {
  # Function to request gpu or cpu access
  # example:
  #    qlogin 2                request 2 gpus
  #    qlogin 1 cpu            request 1 cpu slot
  #    qlogin 1 aml-gpu.q@b5   request 1 gpu on b5
  if [ "$#" -eq 1 ]; then
    /usr/bin/qlogin -now n -p 1024 -pe smp $1 -q aml-gpu.q -l gpu=$1 -N D_$(whoami)
  elif [ "$#" -eq 2 ]; then
    if [ "$2" = "cpu" ]; then
      queue="aml-cpu.q"
    else
      queue="$2"
    fi
    /usr/bin/qlogin -now n -p 1024 -pe smp $1 -q $queue -l gpu=$1 -N D_$(whoami)
  else
    echo "Usage: qlogin <num_gpus>" >&2
    echo "Usage: qlogin <num_gpus> <queue>" >&2
    echo "Usage: qlogin <num_slots> cpu" >&2
  fi
}

qtail () {
  tail -f $(qlog "$@")
}

qlast () {
  # Tail the last running job
  job_id=$(qstat | awk '$5=="r" {print $1}' | grep -E '[0-9]' | sort -r | head -n 1)
  echo "qtail of most recent job ${job_id}"
  qtail ${job_id} 
}

qless () {
  less $(qlog "$@")
}

qcat () {
  cat $(qlog "$@")
}

qlog () {
  # Get log path of job
  if [ "$#" -eq 1 ]; then
    echo $(qstat -j $1 | grep stdout_path_list | cut -d ":" -f4)
  elif [ "$#" -eq 2 ]; then
    log_path=$(qlog $1)
    base_dir=$(echo $log_path | rev | cut -d "/" -f3- | rev)
    filename=$(basename $log_path)
    echo ${base_dir}/log/${filename%.log}.${2}.log
  else
    echo "Usage: qlog <jobid>" >&2
    echo "Usage: qlog <array_jobid> <sub_jobid>" >&2
  fi
}

qdesc () {
  qstat | tail -n +3 | while read line; do
    job=$(echo $line | awk '{print $1}')
    if [[ ! $(qstat -j $job | grep "job-array tasks") ]]; then
      echo $job $(qlog $job)
    else
      qq_dir=$(qlog $job)
      job_status=$(echo $line | awk '{print $5}')
      if [ $job_status = 'r' ]; then
        sub_job=$(echo $line | awk '{print $10}')
        echo $job $sub_job $(qlog $job $sub_job)
      else
        echo $job $qq_dir $job_status
      fi
    fi
  done
}

qrecycle () {
    [ -n  "$SINGULARITY_CONTAINER" ] && ssh localhost "qrecycle"  "$@" || command qrecycle "$@";
}

qupdate () {
    [ -n "$SINGULARITY_CONTAINER" ] && ssh localhost "qupdate"|| command qupdate ;
}

# Only way to get a gpu is via queue. WARNING: this will hide GPUs if working locally
if [ -z $CUDA_VISIBLE_DEVICES ]; then
  export CUDA_VISIBLE_DEVICES=
fi

# clean 

clean_vm () {
    ps -ef | grep zsh | awk '{print $2}' | xargs sudo kill
    ps -ef | grep vscode | awk '{print $2}' | xargs sudo kill
}

