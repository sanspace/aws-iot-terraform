source .venv/scripts/activate
topic=$1
if [ $# -eq 0 ]
  then
    topic="iot/bsm"
fi

python ./BedSideMonitor.py -e "$(<../infra/endpoint.txt)" -r ../infra/AmazonRootCA1.pem -c ../infra/pem.crt -k ../infra/private.key -id "client1" -t $topic
