#! /usr/bin/bash
conda_version_str=$(conda --version | awk '{print $2}')
conda_v_arr=( ${conda_version_str//./ } )                   # replace points, split into array

conda_old_cmd=0
# conda 4.4.0 or later use conda activate not source activate
if [[ $((conda_v_arr[0])) -lt 4 ]];
then
  conda_old_cmd=1
else
  if [[ $((conda_v_arr[1])) -lt 4 ]];
  then
    conda_old_cmd=1
  fi
fi

__source_or_conda(){
  if [ ${conda_old_cmd} == 1 ];
  then
    source $@
  else
    conda $@
  fi
}


DEVTOOL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
# make sure conda is active and we are in the base env
if [ -z ${CONDA_PREFIX} ];
then
  echo "no conda env active activating"
  __source_or_conda activate
else
  if [ ! -z ${CONDA_PREFIX_1} ];
  then
    echo "non base conda env active deactivating"
    __source_or_conda deactivate
  fi
fi
# Run the env creator
echo " running: python ${DEVTOOL_DIR}/create_dev_env.py to setup/update conda env"
python ${DEVTOOL_DIR}/create_dev_env.py

# get the env name
env_name="$(basename "$(cd "${DEVTOOL_DIR}/.." && pwd)" )-dev"
echo "env: ${env_name} created... Activating"

# activate the env
__source_or_conda activate ${env_name}
pip install -e "${DEVTOOL_DIR}/.."

#clean up vars since this script is sourced
unset -f __source_or_conda
unset -v DEVTOOL_DIR
unset -v env_name
unset -v conda_version_str
unset -v conda_v_arr
unset -v conda_old_cmd
