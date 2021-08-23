docker build -t ankitkothana/multi-client:latest -t ankitkothana/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ankitkothana/multi-server:latest -t ankitkothana/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ankitkothana/multi-worker:latest -t ankitkothana/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ankitkothana/multi-client:latest
docker push ankitkothana/multi-server:latest
docker push ankitkothana/multi-worker:latest

docker push ankitkothana/multi-client:$SHA
docker push ankitkothana/multi-server:$SHA
docker push ankitkothana/multi-worker:$SHA

kubectl apply -f k8s

kubectl set deployment/server-deployment server=ankitkothana/multi-server:$SHA
kubectl set deployment/client-deployment client=ankitkothana/multi-client:$SHA
kubectl set deployment/worker-deployment worker=ankitkothana/multi-worker:$SHA