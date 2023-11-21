# OneWAF CTF Lab Guide 🚩



## CTF Scenario

### Topology

![topology](img/Lab/topology.png)

### Credentials

- **BIG-IP**: `admin` / `vonk-gest-prim`
- **F5 XC**: `YOUR_EMAIL` / `YOUR_PASS` 
  - Tenant: `f5-xc-lab-sec`
- **Client**:
  - SSH key
  - WEB SHELL
  - FIREFOX

### Steps

1. [Build F5 XC WAAP tenant](#F5-XC-WAAP-Tenant) in order to be able to participate in this part of the challange.
2. Get familiar with the protected app -> [Juice Shop](https://owasp.org/www-project-juice-shop/)
3. Plan your **WAAP** strategy
4. [Test](#test-the-app) that the apps are accessible
5. Protect the app using *BIG-IP WAF* 
6. Protect the app using *F5 XC*
7. Use **Client** in **UDF** to verify your security policy. You can also use **FIREFOX** link.

<img src="img/Lab/udf-firefox.png" alt="udf-firefox" style="zoom:50%;" />

8. Ask the trainer for the evaluation!



### Notes

- 🛠️ You can use any available feature of *BIG-IP* or *XC* in order to protect the application, however the app *MUST stay accessible to regular users*!
- 👾 The evaluation will be done in the automated way using scripts and web browser to test security policy - *not all the vulnerabilities in the Juice Shop app will be tested!*
- ↩️ Before the evaluation the Juice Shop app will be restarted in order to reset any detected vulnerabilities triggered during the policy building
- 🙋🏻‍♂️ Reach out to the trainer when you are done, as *the best time counts*!



### Results 🥇

We will have the following categories:

1. **App Defender**!
   - best time and top mitigated vulnerabilities in both AWAF and F5 XC protections
2. **AWAF guru**!
   - best time and top mitigated vulnerabilities using AWAF
3. **Modern App Security**!
   - best time and top mitigated vulnerabilities using F5 XC



> Best time and top mitigated vulnerabilities is counted as *time* - (*each mitigated vulnerability = 2min*).



## Lab preparation

### F5 XC WAAP Tenant

This Lab is using F5 XC SEC Lab as the starting point, so you can use the Lab Guide [here](https://clouddocs.f5.com/training/community/f5xc/html/class3/intro.html) to enable WAAP tenant or follow the guide below.

- F5 Distributed Cloud Console: https://f5-xc-lab-sec.console.ves.volterra.io/
- Delegated Domain: **lab-sec.f5demos.com**
- Account name: **f5-xc-lab-sec**

After following the invitation email’s instructions to **Update Password**, proceed to the first step below to access the F5 Distributed Cloud Lab Tenant.

1. Please log into the F5 Distributed Cloud Lab Tenant with your user ID (email) & password. https://f5-xc-lab-sec.console.ves.volterra.io/

<img src="img/Lab/1st-login.png" alt="1st-login" style="zoom: 33%;" />

1. When you first login, accept the Lab tenant EULA. Click the check box and then click **Accept and Agree**.

2. Select all work domain roles and click **Next** to see various configuration options. Roles can be changed any time later if desired.

3. Click the **Advanced** skill level to expose more menu options and then click **Get Started** to begin. You can change this setting after logging in as well.

4. Several **Guidance ToolTips** will appear, you can safely close these as they appear.

5. You can adjust your work domains and skill level (not required) by clicking on the

   **Account** icon in the top right of the screen and then clicking on **Account Settings**.

7. In the resulting window you can observe the **Work domains and skill level** section and other administrative functions.

8. Namespaces, which provide an environment for isolating configured applications or

   enforcing role-based access controls, are leveraged within the F5 Distributed Cloud

   Console. For the purposes of this lab, each lab attendee has been provided a unique

   **namespace** which you will be defaulted to (in terms of GUI navigation) for all tasks

   performed through the course of this lab.

![intro-0088](https://clouddocs.f5.com/training/community/f5xc/html/_images/intro-0088.png)

![intro-0098](https://clouddocs.f5.com/training/community/f5xc/html/_images/intro-0098.png)



## F5 XC LB

In order to be able to protect the JuiceShop in the UDF environment you have to configure the LoadBalancer with the parameters shown below.

Go to **Multi-Cloud App Connect**.

<img src="img/Lab/mcac..png" alt="mcac." style="zoom:50%;" />

Click **Add HTTP Load Balancer**

![lb](img/Lab/lb.png)

Use `YOUR_NAME_SPACE` + `lab-sec.f5demos.com` as the domain name.

Configure **Origin Pool**

- Get the domain name for *JuiceShop* running in **UDF** - open JUICE SHOP & copy domain name.

<img src="img/Lab/udf-js.png" alt="udf-js" style="zoom: 50%;" />

![js-url](img/Lab/js-url.png)

- Configure the **Origin Pool**

<img src="img/Lab/origin-server-0143217.png" alt="origin-server" style="zoom:50%;" />

- keep port **443**

<img src="img/Lab/origin-pool1.png" alt="origin-pool1" style="zoom:50%;" />

- enable **TLS** towards Origin Server

<img src="img/Lab/origin-pool2.png" alt="origin-pool2" style="zoom:50%;" />

**Save and Exit**



## Test the App

Go to **UDF** -> **Client** -> **ACCESS** -> **SSH** or **WEB SHELL** or **FIREFOX**

> You can use **Client** for testing of your security policy.



Test access via **BIG-IP**

```bash
curl -v 10.1.10.105
```

Excpected output:

```http
*   Trying 10.1.10.105:80...
* TCP_NODELAY set
* Connected to 10.1.10.105 (10.1.10.105) port 80 (#0)
> GET / HTTP/1.1
> Host: 10.1.10.105
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Access-Control-Allow-Origin: *
...
< Keep-Alive: timeout=5
<
<!--
  ~ Copyright (c) 2014-2023 Bjoern Kimminich & the OWASP Juice Shop contributors.
```



Test access via **F5 XC WAAP LB** 

```bash
curl -v YOUR_NAME_SPACE.lab-sec.f5demos.com
```

Excpected output:

```http
*   Trying 159.60.128.62:80...
* TCP_NODELAY set
* Connected to huge-earwig.lab-sec.f5demos.com (159.60.128.62) port 80 (#0)
> GET / HTTP/1.1
> Host: huge-earwig.lab-sec.f5demos.com
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< access-control-allow-origin: *
...
< x-volterra-location: tn2-lon
< server: volt-adc
<
<!--
  ~ Copyright (c) 2014-2023 Bjoern Kimminich & the OWASP Juice Shop contributors.
```

If the app is not accessible please reach out to the trainer.
