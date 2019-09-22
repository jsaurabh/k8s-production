docker build -t jsaurabh95/multi-client:latest -t jsaurabh95/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jsaurabh95/multi-server:latest -t jsaurabh95/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jsaurabh95/multi-worker:latest -t jsaurabh95/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push jsaurabh95/multi-client:latest
docker push jsaurabh95/multi-client:$GIT_SHA

docker push jsaurabh95/multi-server:latest
docker push jsaurabh95/multi-server:$GIT_SHA

docker push jsaurabh95/multi-worker:latest
docker push jsaurabh95/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jsaurabh95/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=jsaurabh95/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=jsaurabh95/multi-worker:$GIT_SHA
