# F5 OneWAF CTF

A CTF workshop based on OWASP Juice Shop app. The goal is to mitigate most of the Juice Shop vulnerabilities using F5 AWAF and F5 Distributed Cloud WAAP. F5ers can use *UDF lab* called: **OneWAF - CTF**

The winning team is the one with most of the mitigated vulnerabilities in the shortest time. The result is calculated as `time form the beginning in mins` - `each mitigated vulnerability` * `2`.

Attendees of this workshop should follow the [Lab guide](./Lab.md).

## Notes for the instructor
- please highlight that the attendees MUST follow the procedure in Lab guide in order to be able to correctly count the results
- there are two Docker containers running: `docker_juiceshop-big_1` as backend for **BIG-IP** and `docker_juiceshop-xc_1` as backend for **XC**
- if the attendees somehow break the configuration the testing script is unable to reach the backend and the **results will be incorrect**

## Steps for evaluation
### Reset Docker containers before evaluation
1. Change to Attendee/Team environment in UDF
2. *SSH* to *docker-server* host
3. Reset Docker
    ```bash
    sudo -s
    cd /root/docker
    ./reset-docker.sh
    ```

### Run the testing script
1. Change to Attendee/Team environment in UDF
2. *RDP* to *desktop* host
3. Run *Terminal Emulator*
    ```bash
    cd juice-shop-solver
    git pull
    source venv/bin/activate
    # Run the test for BIG-IP
    ./solutions.py http://10.1.10.105
    # Run the test for XC
    ./solutions.py <ASK FOR THEIR PUBLIC XC LB DOMAIN>
    ```
4. Please double-check that the both apps (BIG-IP and XC hosted) are accessible via regular Browser

### Results
1. Change to Attendee/Team environment in UDF
2. *SSH* to *docker-server* host
3. Run the script for Results
    ```bash
    sudo -s
    cd /root/docker
    ./results.sh
    ```
4. Expected output:
    ```
    ====================================
    /docker_juiceshop-xc_1
    Challanges solved (out of 24): 10


    ====================================
    /docker_juiceshop-big_1
    Challanges solved (out of 24): 4
    ```
    This means that the Attendee/Team was able to mitigate 14 vulnerabilities for XC protected app and 20 vulnerabilities for BIG-IP deployment.
    In case the results show **0** mitigated vulnerabilities, it's **suspicious** and always check whether they really configured the backed the right way!
    **24** challenges solved means no they failed to protect the app.