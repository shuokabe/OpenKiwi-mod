PARSED_OPTIONS=$(getopt -n "$0"  -o h --long "help,task:,data:,model:,vis:"  -- "$@")

if [ $# -eq 0 ];
then
  echo 'No arguments provided. Use --help option for more details.'
  exit 1
fi

eval set -- "$PARSED_OPTIONS"

while true;
do
  case "$1" in

    -h|--help)
     echo -e "usage $0 -h display help \n \
     --help display help \n \
     --task name of the folder containing the task \n \
     --data name of the data file (zip format; name without the .zip) \n \
     --vis use of visual features or not (bool)"
      shift
      exit 0;;

    --task)
      if [ -n "$2" ];
      then
        task_name=$2
      fi
      shift 2;;

    --data)
      if [ -n "$2" ];
      then
        data_name=$2
      fi
      shift 2;;

    --model)
      if [ -n "$2" ];
      then
        model_name=$2
      fi
      shift 2;;

    --vis)
      if [ -n "$2" ];
      then
        vis=$2
      fi
      shift 2;;

    --)
      shift;
      break;;
  esac
done

# Data name
datafile_name=${data_name}.zip

mkdir data/
cp ../${datafile_name} ./data/
cd data/

# Unzip data files
unzip ${datafile_name}

# Move files out of the folder
mv ./${data_name}/* ./

# Return to OpenKiwi folder
cd ..


# Move the pre-trained predictor
mkdir -p runs/predictor
cd runs/predictor
cp ../best_model.torch ./runs/predictor/
