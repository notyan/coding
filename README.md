## Coding Collective Take Home Technical Test
There is two folder, for each Test Case (TC)


### Test Case 1
Located at folder First-TC, Consist of two folder
#### 1. 10MinLog

#### 2. sonarqube
1. Make .env file
```
cp .env.example .env
```
2. Fill .env file as needed
3. Run  docker compose
```
docker compose up 
```
4. The app will run on port `9001` or `localhost:9001`

---

### Test Case 2
Located at folder Second-TC, Consist of Four folder
#### 1. DB-Backup
Bash Script to create a database backup, compression, and 30 days retention period
##### How to 
Edit the `dbBackup.sh`, and change the Configuration as needed, then run the script
```
./dbBackup.sh
```
#### 2. LEMP
Docker Compose file to run LEMP
##### How to
1. Make .env file
```
cp .env.example .env
```
2. Fill .env file as needed
3. Run  docker compose
```
docker compose up
```
4. The app will run at port `8000` or `localhost:8000`

#### 3. SSH-BruteForce
Bash script to block brute force ssh request

#### 4. laravel
Simple laravel project only contain hello world with my name
##### How To
1. Make .env file
```
cp .env.example .env
```
2. Fill .env file as needed
3. Run LEMP docker compose
```
cd ../LEMP/ && docker compose up -d
```
4. Run laravel docker compose
```
cd ../laravel/ docker compose up 
```
5. The app will run on port `2121`  or `localhost:2121`