docker build -t Rubyrubylai/multi-client:latest -t Rubyrubylai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t Rubyrubylai/multi-server:latest -t Rubyrubylai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t Rubyrubylai/multi-worker:latest -t Rubyrubylai/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push Rubyrubylai/multi-client:latest
docker push Rubyrubylai/multi-server:latest
docker push Rubyrubylai/multi-worker:latest
docker push Rubyrubylai/multi-client:$SHA
docker push Rubyrubylai/multi-server:$SHA
docker push Rubyrubylai/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=Rubyrubylai/multi-server:$SHA
kubectl set image deployments/client-deployment client=Rubyrubylai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=Rubyrubylai/multi-worker:$SHA
