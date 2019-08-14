docker build -t phoenix1point618/multi-client:latest -t phoenix1point618/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phoenix1point618/multi-server:latest -t phoenix1point618/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phoenix1point618/multi-worker:latest -t phoenix1point618/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push phoenix1point618/multi-client:latest
docker push phoenix1point618/multi-server:latest
docker push phoenix1point618/multi-worker:latest

docker push phoenix1point618/multi-client:$SHA
docker push phoenix1point618/multi-server:$SHA
docker push phoenix1point618/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phoenix1point618/multi-server:$SHA
kubectl set image deployments/client-deployment client=phoenix1point618/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phoenix1point618/multi-worker:$SHA