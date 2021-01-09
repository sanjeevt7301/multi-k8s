docker build -t sanjeevthakur/multi-client:latest -t sanjeevthakur/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sanjeevthakur/multi-server:latest -t sanjeevthakur/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sanjeevthakur/multi-worker:latest -t sanjeevthakur/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sanjeevthakur/multi-client:latest
docker push sanjeevthakur/multi-server:latest
docker push sanjeevthakur/multi-worker:latest

docker push sanjeevthakur/multi-client:$SHA
docker push sanjeevthakur/multi-server:$SHA
docker push sanjeevthakur/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sanjeevthakur/multi-server:$SHA
kubectl set image deployments/client-deployment client=sanjeevthakur/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sanjeevthakur/multi-worker:$SHA