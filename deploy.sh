docker build -t prashanth20/fibbcalc-client:latest -t prashanth20/fibbcalc-client:$SHA -f ./client/Dockerfile ./client
docker build -t prashanth20/fibbcalc-server:latest -t prashanth20/fibbcalc-server:$SHA -f ./server/Dockerfile ./server
docker build -t prashanth20/fibbcalc-worker:latest -t prashanth20/fibbcalc-worker:$SHA -f ./worker/Dockerfile ./worker

# take all images and push them to docker hub
docker push prashanth20/fibbcalc-client:latest
docker push prashanth20/fibbcalc-server:latest
docker push prashanth20/fibbcalc-worker:latest

docker push prashanth20/fibbcalc-client:$SHA
docker push prashanth20/fibbcalc-server:$SHA
docker push prashanth20/fibbcalc-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=prashanth20/fibbcalc-server:$SHA
kubectl set image deployments/client-deployment client=prashanth20/fibbcalc-client:$SHA
kubectl set image deployments/worker-deployment worker=prashanth20/fibbcalc-worker:$SHA