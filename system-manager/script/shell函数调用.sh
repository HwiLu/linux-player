------------example------------------
#!/bin/bash
function getJobId(){
  grep -a "Running job: job_"  jobStatus.log | awk '{print $NF}' | sort | uniq >> jobId.txt
  jobId=`tail -n 1 jobId.txt`
  
  echo $jobId
  #return $jobId #不推荐使用
}
getJobId
echo $(getJobId)
