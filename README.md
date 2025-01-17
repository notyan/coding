## Coding Collective Take Home Technical Test
There is two folder, for each Test Case (TC)

---
### Test Case 1
Located at folder `First-TC`, Consist of two folder
#### 1. 10MinLog
The script is `tailLog.sh`, It have multiple options

```
This option will analyze latest modified log file
-e        Count and show 500 Http Response Code
-a        Count and show all Http Response Code
-i        Get top 5 ip that sent the request
This option will analyze all log file
-f        Analyze All log File
```

#### 2. sonarqube
1. Make .env file
```
cp .env.example .env
```
2. Fill .env file as needed
3. Change the `vm.max_map_count` value to 262144 on the `/etc/sysctl.conf`, or run 
```
echo "vm.max_map_count=262144" >> /etc/sysctl.conf 
```
4. Reload the configuration
```
sudo sysctl -p
```
5. Run  docker compose
```
docker compose up 
```
6. The app will run on port `9001` or `localhost:9001`
---

### Test Case 2
Located at folder `Second-TC`, Consist of Four folder
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
3. Run  the script
```
./lemp.sh
```
4. The script will show where the app run

To cleanup the lemp folder run
```
./lemp.sh --cleanup
```

#### 3. SSH-BruteForce
Bash script to block brute force ssh request
##### How To
1. Run the main script
```
./secureSSH.sh
```
2. It will show the option available
```
Use theese tree option to secure your ssh
-b    block all bruteforce attempt
-u    unblock ip
-h    hardening the ssh
```
3. Chose the one needed

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
cd ../laravel/ docker compose up --build
```
5. The app will run on port `2121`  or `localhost:2121`