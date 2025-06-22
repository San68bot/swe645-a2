# SWE645 - Assignment 1
Sanjay Mohan Kumar

---

## Deployment URLs

* **Amazon S3 URL:** `http://smohanku-swe645-hw1.s3-website.us-east-2.amazonaws.com`
* **Amazon EC2 URL:** `http://18.118.145.155/`

---

## Part 1: AWS S3 Static Website Deployment Steps

Here are the steps to deploy the website on Amazon S3:

1.  **Create an S3 Bucket:**
    * Sign in to the AWS Management Console and open the S3 service.
    * Click "Create bucket".
    * Enter a globally unique bucket name.
    * Select an AWS Region.
    * Under "Object Ownership," select "ACLs enabled" and "Bucket owner preferred."
    * **Uncheck** "Block all public access" and acknowledge the warning. This is necessary for a public website.
    * Click "Create bucket".

2.  **Upload Website Files:**
    * Navigate into your newly created bucket.
    * Click "Upload".
    * Click "Add files" to upload `index.html` and `survey.html`.
    * Click "Add folder" to upload the entire `assets` directory.
    * Click "Upload" to transfer the files.

3.  **Enable Static Website Hosting:**
    * In your bucket, go to the "Properties" tab.
    * Scroll down to "Static website hosting" and click "Edit".
    * Select "Enable".
    * In "Index document," enter `index.html`.
    * Optionally, in "Error document," enter `error.html`.
    * Click "Save changes". Note the "Bucket website endpoint" URL provided.

4.  **Set Bucket Policy for Public Access:**
    * Go to the "Permissions" tab of your bucket.
    * Under "Bucket policy," click "Edit".
    * Paste the following JSON policy, replacing `[your-bucket-name]` with your bucket's name. This allows public read access to your website files.
    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::[your-bucket-name]/*"
        }
      ]
    }
    ```
    * Click "Save changes". The website is now live at the endpoint URL from the previous step.

---

## Part 2: EC2 Instance Deployment Steps

Here are the steps to deploy the website on an Amazon EC2 instance:

1.  **Launch an EC2 Instance:**
    * Open the EC2 service in the AWS Console and click "Launch instance".
    * Give your instance a name.
    * For the "Application and OS Images (Amazon Machine Image)," select **Amazon Linux 2 AMI** (or a similar Linux distribution).
    * For "Instance type," choose `t2.micro` as it is Free Tier eligible.
    * Create a new key pair or select an existing one to securely connect to your instance. **Download and save the .pem file.**

2.  **Configure Security Group:**
    * In "Network settings," click "Edit".
    * For "Security group," create a new one.
    * Add two inbound security group rules:
        * **Rule 1 (SSH):** Type `SSH`, Source type `My IP` (for security).
        * **Rule 2 (HTTP):** Type `HTTP`, Source type `Anywhere`. This opens port 80 to allow web traffic.
    * Click "Launch instance".

3.  **Install and Configure a Web Server (Apache):**
    * Connect to the EC2 instance using SSH.
    * Once connected, run the following commands to install and start the Apache web server:
    ```bash
    # Update all packages
    sudo yum update -y
    
    # Install Apache HTTP Server
    sudo yum install -y httpd
    
    # Start the Apache service
    sudo systemctl start httpd
    
    # Enable Apache to start on boot
    sudo systemctl enable httpd
    ```

4.  **Deploy Website Files to EC2:**
    * The web server's root directory is `/var/www/html`. You need to place your files there.
    * First, grant your user permissions to the directory:
    ```bash
    sudo chown -R $USER:$USER /var/www/html
    ```
    * Use an SCP (Secure Copy Protocol) client like `scp` (on Mac/Linux) or WinSCP (on Windows) to transfer your files from your local machine to the instance's `/var/www/html` directory.
    * Example `scp` command (run from your local terminal in your project folder):
    ```bash
    # Replace 'your-key.pem' and 'your-ec2-ip'
    scp -i your-key.pem -r ./* ec2-user@[your-ec2-ip]:/var/www/html/
    ```
    * Your website is now accessible via the instance's Public IPv4 address. You can find this on the EC2 instance summary page.