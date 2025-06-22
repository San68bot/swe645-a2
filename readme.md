# SWE645 - Assignment 2

**Group Member(s):** `[Your Name(s) and Contributions]`

---

## Deployment URLs

* **S3 Homepage URL (from HW1):** `http://smohanku-swe645-hw1.s3-website.us-east-2.amazonaws.com`
* **Kubernetes Application URL:** `http://aabf84b0e48544021b49726c1c3867ac-304170381.us-east-1.elb.amazonaws.com/`

---

## Part 1: Setup and Installation Instructions

This section details the setup of the environment and tools used.

### **Prerequisites**
* A GitHub Account
* A Docker Hub Account (or Amazon ECR)
* An AWS Account (for EKS)
* A running Jenkins instance
* `kubectl` command-line tool installed locally

### **Setup Instructions**

1.  **GitHub Repository Setup:**
    * Create a new repository on GitHub.
    * Push the project files (`index.html`, `Dockerfile`, `Jenkinsfile`, etc.) to this repository.

2.  **Container Registry Setup (Docker Hub):**
    * Log in to Docker Hub.
    * Create a new public repository (e.g., `swe645-webapp`).

3.  **Kubernetes Cluster Setup (AWS EKS):**
    * Use `eksctl` or the AWS Management Console to create an EKS cluster. Example `eksctl` command:
        ```bash
        eksctl create cluster --name swe645-cluster --region us-east-1 --nodegroup-name standard-workers --node-type t2.micro --nodes 3
        ```
    * After creation, configure `kubectl` to communicate with your cluster:
        ```bash
        aws eks --region your-region update-kubeconfig --name swe645-cluster
        ```

4.  **Jenkins Setup:**
    * **Install Plugins:** In Jenkins, go to `Manage Jenkins` > `Plugins` and install `Docker Pipeline`, `Kubernetes CLI`, and `Pipeline: AWS`.
    * **Add Credentials:**
        1.  **Docker Hub:** Go to `Manage Jenkins` > `Credentials`. Add new "Username with password" credentials for your Docker Hub account. Use `dockerhub-credentials` as the ID.
        2.  **Kubeconfig:** Add new "Secret file" credentials. Upload your `~/.kube/config` file (which `aws eks update-kubeconfig` created) and give it the ID `kubeconfig`.
    * **Create Jenkins Pipeline:**
        1.  Create a new "Pipeline" project.
        2.  Under "Pipeline," select "Pipeline script from SCM."
        3.  Choose "Git" and enter your GitHub repository URL.
        4.  The "Script Path" should be `Jenkinsfile`.

### **Demonstration Video**
The video recording demonstrates the following: https://youtu.be/_wmDQAL39uU
1.  A walkthrough of the files (`Dockerfile`, `Jenkinsfile`, `deployment.yaml`).
2.  A manual build and push of the Docker image.
3.  A manual deployment to Kubernetes using `kubectl apply -f k8s/deployment.yaml`.
4.  Making a change to `index.html`, pushing it to GitHub, and showing the Jenkins pipeline trigger automatically.
5.  Showing the new version of the website running on the Kubernetes LoadBalancer URL.

### **References**
* **Docker:** [https://docs.docker.com/](https://docs.docker.com/)
* **Kubernetes:** [https://kubernetes.io/docs/](https://kubernetes.io/docs/)
* **Jenkins:** [https://www.jenkins.io/doc/](https://www.jenkins.io/doc/)
* **AWS EKS:** [https://docs.aws.amazon.com/eks/](https://docs.aws.amazon.com/eks/)