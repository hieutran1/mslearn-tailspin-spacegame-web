## Learning Paths
- Learn about the basics of Docker containers, container orchestration with Kubernetes, and managed clusters on Azure Kubernetes Service 
    + 1. Part 1: Introduction to Kubernetes on Azure
        - https://learn.microsoft.com/en-us/training/paths/intro-to-kubernetes-on-azure/
    + 2. Part 2: Azure Kubernetes Service (AKS) cluster architecture and operations
        - https://learn.microsoft.com/en-us/training/paths/aks-cluster-architecture/
    + 3. Part 3: Azure Kubernetes Service (AKS) application and cluster scalability
        - https://learn.microsoft.com/en-us/training/paths/aks-cluster-scalability/

## Part 1: Introduction to Kubernetes on Azure
- https://learn.microsoft.com/en-us/training/paths/intro-to-kubernetes-on-azure/

### Introduction to Docker containers
- https://learn.microsoft.com/en-us/training/modules/intro-to-docker-containers

- For example, assume we're developing an order-tracking portal for our company's various outlets to use. 
    + Several environments host our applications during the app's development and publishing process. 
    + First, the development team develops and tests the software in a development environment. 
    + From here, the software is then deployed to a quality assurance (QA) environment, followed by pre-production, and a final production environment.

1. What is Docker?
    1. What is a container?
        - A container is a loosely isolated environment that allows us to build and run software packages.
        - The container image becomes the unit we use to distribute our applications.

    2. What is software containerization?
        - Software containerization is an OS-virtualization method used to deploy and run containers without using a virtual machine (VM).
            + Containers can run on physical hardware, in the cloud, on VMs, and across multiple operating systems.

    3. What is Docker?
        - Docker is a containerization platform used to develop, ship, and run containers.

        - For production systems, Docker is available for server environments, including many variants of Linux and Microsoft Windows Server 2016 and above. 
        - Many clouds, including Azure, support Docker.

        1. Docker architecture
            - The Docker platform consists of several components that we use to build, run, and manage our containerized applications.

            1. Docker Engine
                - The Docker Engine consists of several components configured as a client-server implementation where the client and server run simultaneously on the same host.

                1. The Docker client
                    - There are two alternatives for Docker client: A command-line application named docker, or a Graphical User Interface (GUI) based application called Docker Desktop.

                2. The Docker server
                    - The Docker server is a daemon named **dockerd**.

                    - The Docker server is also responsible for tracking the lifecycle of our containers.

                3. Docker objects
                    - There are several objects that you'll create and configure to support your container deployments.
                        + 1. networks
                        + 2. storage volumes
                        + 3. plugins
                        + 4. and other service objects

            2. Docker Hub
                - Docker Hub is a Software as a Service (SaaS) Docker container registry. 
                    + Docker registries are repositories that we use to store and distribute the container images we create. 
                    + Docker Hub is the default public registry Docker uses for image management.

                    + private Docker registry, cloud provider, Azure Container Registry

2. How Docker images work
    - differences between software, packages, and images as used in Docker.
    - the roles of the OS running on the host and the OS running in the container.

    1. Software packaged into a container
        - When we talk about software, we refer to *application code*, *system packages*, *binaries*, *libraries*, *configuration files*, and the operating system running in the container.

        - EX: developing an order-tracking portal for our company's various outlets to use.
            + We need to look at the *complete stack of software* that will run our web application.
                + The application we're building is a .NET Core MVC app, 
                + and we plan to deploy the application using *nginx* as a *reverse proxy server* on *Ubuntu Linux*.
            + All of these software components form part of the container image.

    2. What is a container image?
        - A container image is a portable package that contains software.
            + The container is an image's in-memory instance.

    3. What is the host OS?
        - The host OS is the OS on which the Docker engine runs. 
            + Docker containers running on Linux share the host OS kernel, and don't require a container OS as long as the binary can access the OS kernel directly.
            + However, Windows containers need a container OS.
        
        - The container depends on the OS kernel to manage services such as the *file system*, *network management*, *process scheduling*, and *memory management*.

    4. What is the container OS?
        - The container OS is the OS that's part of the packaged image.
            + We have the flexibility to include different versions of Linux or Windows operating systems in a container. 
            + This flexibility allows us to access specific OS features or install additional software our applications might use.

    5. What is the Stackable Unification File System (Unionfs)?
        - We use Unionfs to create Docker images. 
        - Unionfs is a filesystem that allows you to stack several directories—called branches—in such a way that it appears as if the content is merged.

        - For example, assume we're building an image for our web application from earlier:
            + 1. layer the Ubuntu distribution as a *base image* on top of the *boot file system*
            + 2. Next, install *nginx* and our *web app*.
                - layering nginx and the web app on top of the original Ubuntu image.
            + 3. A final writeable layer is created once the container is run from the image.
                - However, this layer doesn't persist when the container is destroyed.

    6. What is a base image?
        - A base image is an image that uses the Docker **scratch** image.
            + The **scratch** image is an empty container image that doesn't create a filesystem layer. 
            + This image assumes that the application you're going to run can directly use the host OS kernel.

    7. What is a parent image?
        - A parent image is a container image from which you create your images.

        - For example, instead of creating an image from **scratch** and then installing Ubuntu, 
            + we'll use an image already based on Ubuntu. 
            + We can even use an image that already has nginx installed. 
            + A parent image usually includes a container OS.

    8. What is the main difference between base and parent images?
        - Both image types allow us to create a reusable image.
        - However, base images allow us more control over the final image contents. 

        - On Windows, you can only create container images that are based on Windows base container images. 
            + Microsoft provides and services these Windows base container images.

    9. What is a Dockerfile?
        - A Dockerfile is a text file that contains the instructions we use to build and run a Docker image.
        - It defines the following aspects of the image:
            + 1. The base or parent image we use to create the new image
            + 2. Commands to update the base OS and install additional software
            + 3. Build artifacts to include, such as a developed application
            + 4. Services to expose, such as storage and network configuration
            + 5. Command to run when the container is launched

        - Dockerfile ASP.NET Core website: from local machine to container image
            ``` Bash
            # Step 1: Specify the parent image for the new image
            FROM ubuntu:18.04

            # Step 2: Update OS packages and install additional software
            RUN apt -y update &&  apt install -y wget nginx software-properties-common apt-transport-https \
                && wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
                && dpkg -i packages-microsoft-prod.deb \
                && add-apt-repository universe \
                && apt -y update \
                && apt install -y dotnet-sdk-3.0

            # Step 3: Configure Nginx environment
            CMD service nginx start

            # Step 4: Configure Nginx environment
            COPY ./default /etc/nginx/sites-available/default

            # STEP 5: Configure work directory
            WORKDIR /app

            # STEP 6: Copy website code to container
            COPY ./website/. .

            # STEP 7: Configure network requirements
            EXPOSE 80:8080

            # STEP 8: Define the entry point of the process that runs in the container
            ENTRYPOINT ["dotnet", "website.dll"]
            ```
            + **COPY** command copies the content from a specific folder on the local machine to the container image we're building.
            + Docker images make use of **unionfs**.
                - Each of these steps creates a cached container image as we build the final container image.
                - These temporary images are layered on top of the previous image and presented as single image once all steps complete.
            + Finally, notice the last step, step 8. 
                - The **ENTRYPOINT** in the file indicates which process will execute once we run a container from an image.
                    + If there's no ENTRYPOINT or another process to be executed, Docker will interpret that as there's nothing for the container to do, and the container will exit.

    10. How to manage Docker images
        - Docker images are large files that are initially stored on your PC, and we need tools to manage these files.

        - The Docker CLI and Docker Desktop allow us to manage images by building, listing, removing, and running them.
        - We manage Docker images by using the docker client.
            + The client doesn't execute the commands directly, and sends all queries to the **dockerd** daemon.

    11. How to build an image
        - use the *docker build* command to build Docker images
        ```
        docker build -t temp-ubuntu .
        ```
        - Notice the steps listed in the output. When each step executes, a new layer gets added to the image we're building.
        - Also, notice that we execute a number of commands to install software and manage configuration.
        - For example, in step 2, we run the *apt -y update* and *apt install -y* commands to update the OS. 
            + These commands execute in a running container created for that step. 
            + Once the command runs, the intermediate container is removed. 
            + The underlying cached image is kept on the build host and not automatically deleted. 
            + This optimization ensures that later builds reuse these images to speed up build times.

    12. What is an image tag? **-t command flag**
        - An image tag is a text string that's used to version an image.
    13. How to list images: `docker images`
    14. How to remove an image: `docker rmi temp-ubuntu:version-1.0`

3. How Docker containers work
    1. How to manage Docker containers
        - command: run, pause, stop, kill, remove

    2. How to view available containers: `docker ps -a`, `-a` argument all.
        - columns: Image, Status, and Names
        1. Why are containers given a name?
            - This feature allows you to run multiple container instances of the same image. 
                + Container names are unique, which means if you specify a name, you can't reuse that name to create a new container.

    3. How to run a container: `docker run -d tmp-ubuntu`
        -  `-d`: to run the container with our website in the background

    4. How to pause a container: `docker pause happy_wilbur`
        1. How to restart a container: `docker restart happy_wilbur`
        2. How to stop a container: `docker stop happy_wilbur`
        3. How to remove a container: `docker rm happy_wilbur`

    5. Docker container storage configuration
        - always consider containers as temporary when the app in a container needs to store data.

        - Let's assume your tracking portal creates a log file in a subfolder to the root of the app; that is, directly to the container file system. 
            + When your app writes data to the log file, the system writes the data to the **writable container layer**.
        - Even though this approach works, it unfortunately has several drawbacks:
            + 1. Container storage is temporary.
            + 2. Container storage is coupled to the underlying host machine
            + 3. Container storage drives are less performant

        - Containers can make use of two options to persist data. 
            + The first option is to make use of **volumes**, and the second is **bind mounts**.

        1. What is a volume?
            - A volume is stored on the host filesystem at a specific folder location. 
                + Choose a folder where you know the data won't be modified by non-Docker processes.

            - Docker creates and manages the new volume by running the **docker volume create** command. 
                + This command can form part of our Dockerfile definition, which means that you can create volumes as part of the container-creation process.
                + Docker creates the volume if it doesn't exist when you try to mount the volume into a container the first time.

            - Volumes are stored within directories on the host filesystem. 
                + Docker mounts and manages the volumes in the container.
                + After mounting, these volumes are isolated from the host machine.

            - Multiple containers can simultaneously use the same volumes.
                + Volumes also don't get removed automatically when a container stops using the volume.

            - In this example, you can create a directory on our container host and mount this volume into the container when you create the tracking-portal container.
                + When your tracking portal logs data, you can access this information via the container host's filesystem.
                + You'll have access to this log file even if your container is removed.

            - Docker also provides a way for third-party companies to build add-ons to be used as volumes. 
                + For example, Azure Storage provides a plugin to mount Azure Storage as volumes on Docker containers.

        2. What is a bind mount?
            - A bind mount is conceptually the same as a volume; 
                + however, instead of using a specific folder, you can mount any file or folder on the host.
                + You're also expecting that the host can change the contents of these mounts. 
                + Just like volumes, the bind mount is created if you mount it and it doesn't yet exist on the host.

            - Bind mounts have limited functionality compared to volumes, 
                + and even though they're more performant, they depend on the host having a specific folder structure in place.

            - Volumes are considered the preferred data-storage strategy to use with containers.

            - For Windows containers, another option is available: you can mount an SMB path as a volume and present it to containers. 
                + This allows containers on different hosts to use the same persistent storage.

    6. Docker container network configuration
        - The default Docker network configuration allows for isolating containers on the Docker host. 
            + This feature allows you to build and configure apps that can communicate securely with each other.

        - Docker provides different network settings for Linux and Windows.

        - For Linux, there are six preconfigured network options:
            + **Bridge** (default on Linux)
            + Host, Overlay, IPvLan, MACvLan, None

        - For Windows, there are six preconfigured network options:
            + **NAT (Network Address Translation)** (default on Windows)
            + Transparent
            + Overlay
            + L2Bridge
            + L2Tunnel
            + None

        - You can choose which of these network configurations to apply to your container depending on its network requirements.

        1. What is the bridge network?
            - The bridge network is the default configuration applied to containers when launched without specifying any other network configuration. 
                + This network is an internal, private network used by the container, and it isolates the container network from the Docker host network.

            - Each container in the bridge network is assigned an IP address and subnet mask, with the hostname defaulting to the container name. 
                + Containers connected to the default bridge network are allowed to access other bridge-connected containers by IP address.
                + The bridge network doesn't allow communication between containers using hostnames.

            - By default, Docker doesn't publish any container ports.
                + To enable port mapping between the container ports and the Docker host ports, use the Docker port **--publish** flag.

            - The publish flag effectively configures a firewall rule that maps the ports.

            - In this example, your tracking portal is accessible to clients browsing to port 80. 
                + You'll have to map port 80 from the container to an available port on the host. 
                + You have port 8080 open on the host, which allows you to set the flag like this:
                    ```
                    --publish 8080:80
                    ```
                    - Any client browsing to the Docker host IP and port 8080 can access the tracking portal.

            - Aside from Linux-specific configurations, the NAT network on Windows hosts functions the same as a bridge network. 
                + Also, NAT is the default network on Windows, and all containers will connect to it unless otherwise specified.

        2. What is the host network?
            - The host network enables you to run the container on the host network directly. 
                + This configuration effectively removes the isolation between the host and the container at a network level.

            - In this example, let's assume you decide to change the networking configuration to the host network option.
                + Your tracking portal is still accessible using the host IP. 
                + You can now use the well-known port 80 instead of a mapped port.

            - Keep in mind that the container can use only ports the host isn't already using.

            - On Windows, the host network isn't available. 
                + On Windows hosts, there's no option to share the same IP address (networking stack) between the host and container.
                + The NAT network functions much like a bridge network, 
                    - and the **Overlay** option provides an IP address to the container from the same network as the host, but not the same IP address.

        3. Overlay and other network options
            - For more advanced scenarios, both Linux and Windows provide additional network options. 
                + For example, the overlay option creates a virtual switch from the host network, 
                + so containers on that network can get IP addresses from DHCP servers or operate with IP addresses from that network segment.
                + Furthermore, Docker allows third-party vendors to create network plugins.

        4. What is the none network?
            - To disable networking for containers, use the none network option. 
                + This might be useful if you have an application that doesn't use the network, 
                + or if you just want to validate that an application runs as expected in a container.
        
        5. Operating system considerations
            - Keep in mind that there are differences among desktop operating systems for the Docker network-configuration options.
            - For example, the *Docker0* network interface isn't available on macOS when using the bridge network, 
                + and using the host-network configuration isn't supported for both Windows and macOS desktops.

4. When to use Docker containers
    - Recall from earlier that there are a number of challenges our team faces as they develop and publish our order-tracking portal. 
    - They're looking for a solution to:
        + Manage our hosting environments with ease.
        + Guarantee continuity in how we deliver our software.
        + Ensure we make efficient use of server hardware.
        + Allow for the portability of our applications.
    - Docker is a solution to these challenges.

    1. Docker benefits
        1. Efficient hardware use
            - Containers run without using a virtual machine (VM). 
            - As we learned, the container relies on the host kernel for functions such as file system, network management, process scheduling, and memory management.

            - Compared to a VM, we can see that a VM requires an OS installed to provide kernel functions to the running applications inside the VM. 
                + Keep in mind that the VM OS also requires disk space, memory, and CPU time. 
                + By removing the VM and the additional OS requirement, we can free resources on the host and use it for running other containers.

        2. Container isolation
            - Docker containers provide security features to run multiple containers simultaneously on the same host without affecting each other.
            - As we learned, we can configure both *data storage* and *network configuration* to isolate our containers or share data and connectivity between specific containers.

        3. Application portability
            - Containers run almost everywhere: desktops, physical servers, VMs, and in the cloud. 
                + This runtime compatibility makes it easy to move containerized applications among different environments.
            
            - Because containers are lightweight, they don't suffer from slow startup or shutdown times like VMs. 
                + This aspect makes redeployment and other deploy scenarios—such as scaling up or down—smooth and fast.

        4. Application delivery
            - With Docker, the container becomes the unit we use to distribute applications. 
                + This concept ensures that we have a standardized container format both our developer and operations teams use. 
                + Our developers can focus on developing software, and the operations team can focus on the deploying and managing software.

        5. Managing hosting environments
            - We configure our application's environment internally to the container.
                + This containment provides flexibility for our operations team to manage the application's environment much closer. 
                + Our team can monitor OS updates, apply security patches once, and roll out the updated container as needed.

        6. Cloud deployments
            - Docker containers are the default container architecture the Azure containerization services use, and many other cloud platforms also support them.

            - For instance, you can deploy Docker containers to Azure Container Instances, Azure App Service, and Azure Kubernetes Services.
            - For example, Azure container instances allow you to focus on designing and building your applications without the overhead of managing infrastructure.
                + When you have many containers to orchestrate, Azure Kubernetes service makes it easy to deploy and manage large-scale container deployments.

    2. When not to use Docker containers
        - Docker containers provide many benefits, but keep in mind that containers may not fit all of your requirements.
        - There are a few aspects to keep in mind:
            1. Security and virtualization
                - Containers provide a level of isolation. 
                    + However, containers share a single host OS kernel, which can be a single point of attack.

                - Windows hosts provide an additional isolation model on which a purpose-built VM can be used to isolate the container at the hypervisor level. 
                    + This mode is called Hyper-V isolation mode, and adds another layer of security between containers and container host.

                - We also need to take into account aspects such as storage and networks to make sure that we consider all security aspects.
                - For example, all containers use the bridge network by default and can access each other via IP address.

                - Not all applications benefit from containerization. In such instances, it might make more sense to use a VM.

            2. Service monitoring
                - Managing the applications and containers is more complicated than traditional VM deployments. 
                    + There are logging features that tell us about the state of the running containers, but more detailed information about services inside the container is harder to monitor.

                - For example, Docker provides us with the docker stats command. 
                    + This command returns information for the container such as percentage CPU usage, percentage memory usage, I/O written to disk, network data sent and received, and process IDs assigned. 
                    + This information is useful as an immediate data stream; however, no aggregation is done, because the data isn't stored. 
                    + We'd have to install third-party software for meaningful data capture over a period of time.

5. Learn more:
    - Get started with Docker remote containers on WSL 2: https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers
              
### Introduction to Kubernetes
- https://learn.microsoft.com/en-us/training/modules/intro-to-kubernetes/

1. What is Kubernetes?
    1. What is **container management**?
        - Container management is the process of organizing, adding, removing, or updating a significant number of containers
        - EX: The drone-tracking app consists of multiple microservices responsible for tasks like **caching**, **queuing**, or **data processing**.
            + Each of these services is hosted in a container that's deployed, updated, and scaled independently from one another.
            + Next, assume that you've increased the number of caching instances and need to roll out a new version of the microservice. 
                - You need to update all the active containers to use the new version.

    2. What is a **container orchestrator**?
        - A container orchestrator is a system that automatically deploys and manages containerized apps.
            + As part of management, the orchestrator handles scaling dynamic changes in the environment to increase or decrease the number of deployed instances of the app.
            + It also ensures all deployed container instances are updated when a new version of a service is released.

    3. Define Kubernetes
        - Kubernetes is a portable, extensible open-source platform for managing and orchestrating containerized workloads.

    4. Kubernetes benefits
        - The benefits of using Kubernetes are based on the abstraction of tasks.
        - These tasks include:
            + Self-healing of containers; for example, restarting containers that fail or replacing containers
            + Scaling deployed container count up or down dynamically, based on demand
            + Automating rolling updates and rollbacks of containers
            + Managing storage
            + Managing network traffic
            + Storing and managing sensitive information such as usernames and passwords

    5. Kubernetes considerations
        - 1. Aspects such as deployment, scaling, load balancing, logging, and monitoring are all optional.
            + You're responsible for finding the best solution that fits your needs to address these aspects
        - 2. Kubernetes doesn't limit the types of apps that can run on the platform.
            + If your app can run in a container, it can run on Kubernetes
        - 3. Kubernetes doesn't provide middleware, data-processing frameworks, databases, caches, or cluster-storage systems.
            + All these items are run as containers or as part of another service offering.
        - 4. For Kubernetes to run containers, it needs a container runtime like Docker or containerd. 
            + The container runtime is the object that's responsible for managing containers.
        - 5. You're responsible for maintaining your Kubernetes environment.
            + manage the hardware configuration of the host machines, such as networking, memory, and storage.

2. How Kubernetes works: all the components that make up a Kubernetes installation
    1. What is a **computer cluster**?
        - A cluster is a set of computers that you configure to work together and view as a single system.
            + The computers configured in the cluster handle the same kinds of tasks.
        - A cluster uses centralized software that's responsible for scheduling and controlling these tasks.
            + The computers in a cluster that **run the tasks** are called **nodes**, 
            + and the computers that **run the scheduling software** are called **control planes**.

    2. Kubernetes architecture
        ```
        Kubernetes cluster
            --> Control plane
                --> kube-api-server
                --> controller
                --> scheduler
                --> etcd
            --> Node 1
                --> kubelet
                --> kube-proxy
                --> Container Runtime
            --> Node 2
        ```

        - A Kubernetes cluster contains at least one main plane and one or more nodes.
            + The default host OS in Kubernetes is Linux, with default support for Linux-based workloads.

        1. Kubernetes control plane
            - The Kubernetes control plane in a Kubernetes cluster runs a collection of services that manage the orchestration functionality in Kubernetes.
            - In production and cloud deployments such as Azure Kubernetes Service (AKS),
                + you find that the preferred configuration is a high-availability deployment with three to five replicated control planes.
        2. Kubernetes node
            - A node in a Kubernetes cluster is where your compute workloads run. 
                + Each node communicates with the control plane via the API server to inform it about state changes on the node.

        3. Services that run on a control plane
            - to manage aspects such as cluster-component communication, workload scheduling, and cluster-state persistence.
            - services:
                + API server
                + Backing store
                + Scheduler
                + Controller manager
                + Cloud controller manager
            1. What is the API server?
                - API server as the front end to your Kubernetes cluster's control plane. 
                    + All the communication between the components in Kubernetes is done through this API.
            2. What is the backing store?
                - The backing store is a persistent storage in which your Kubernetes cluster saves its completed configuration.
                - Kubernetes uses a high-availability, distributed, and reliable key-value store called **etcd**.
                    + This key-value store stores the current state and the desired state of all objects within your cluster.
                    + In a production Kubernetes cluster, 
                        - the official Kubernetes guidance is to have three to five replicated instances of the etcd database for high availability.
            3. What is the scheduler?
                - The scheduler is the component that's responsible for the assignment of workloads across all nodes.
                    + The scheduler monitors the cluster for newly created containers and assigns them to nodes.
            4. What is the controller manager?
                - The controller manager launches and monitors the controllers configured for a cluster through the API server.

                - Kubernetes uses controllers to track object states in the cluster. 
                    + The controller communicates with the API server to determine the object's state. 
            5. What is the cloud controller manager?
                - The cloud controller manager integrates with the underlying cloud technologies in your cluster when the cluster is running in a cloud environment.
                    + These services can be load balancers, queues, and storage, for example.
        
        4. Services that run on a node
            - to control how workloads run.
            - services:
                + Kubelet
                + Kube-proxy
                + Container runtime
            1. What is the kubelet?
                - The kubelet is the agent that runs on each node in the cluster and monitors work requests from the API server.
                    + It makes sure that the requested unit of work is running and healthy.
            2. What is kube-proxy?
                - The kube-proxy component is responsible for local cluster networking and runs on each node.
                    + It ensures that each node has a unique IP address.
                    + It also implements rules to handle routing and load balancing of traffic by using iptables and IPVS.

                - This proxy doesn't provide DNS services by itself. 
                    + A DNS cluster add-on based on CoreDNS is recommended and installed by default.
            3. What is the container runtime?
                - The container runtime is the underlying software that runs containers on a Kubernetes cluster.
                    + The runtime is responsible for fetching, starting, and stopping container images.
                    + Kubernetes supports several container runtimes, including but not limited to Docker, containerd, rkt, CRI-O, and frakti. 
                - The default container runtime in AKS is **containerd**, an industry-standard container runtime.

        5. Interact with a Kubernetes cluster
            - Kubernetes provides a command-line tool called **kubectl** to manage your cluster.
                + use **kubectl** to send commands to the cluster's control plane or 
                    - fetch information about all Kubernetes objects via the API server.
            
            - kubectl uses a configuration file: configuration information
                + **Cluster**: specifies a cluster name, certificate information, and the service API endpoint associated with the cluster.
                + **User**: specifies the users and their permission levels
                + **Context**: groups clusters and users by using a friendly name.
                    + Ex: you might have a "dev-cluster" and a "prod-cluster" to identify your development and production clusters.

        6. Kubernetes pods
            - A pod represents a single instance of an app running in Kubernetes.
                + The workloads that you run on Kubernetes are containerized apps.
                + Unlike in a Docker environment, you can't run containers directly on Kubernetes.
                    - You package the container into a Kubernetes object called a pod. 
                    - A pod is the smallest object that you can create in Kubernetes.

            - A single pod can hold a group of one or more containers.
                + However, a pod typically doesn't contain multiples of the same app.

            - A pod includes information about the shared storage and network configuration and a specification about how to run its packaged containers. 
                + You use pod templates to define the information about the pods that run in your cluster. 
                + Pod templates are YAML-coded files that you reuse and include in other objects to manage pod deployments.
                    - Ex: want to deploy a website to a Kubernetes cluster.
                        + create the pod definition file that specifies the app's container images and configuration. 
                        + Next, you deploy the pod definition file to Kubernetes.

            - Assume that your site uses a database. 
                + The website is packaged in the main container, and the database is packaged in the supporting container.
                + Multiple containers communicate with each other through an environment.
                + The containers include services for a host OS, network stack, kernel namespace, shared memory, and storage volume. 
                + The pod is the sandbox environment that provides all of these services to your app. 
                + The pod also allows the containers to share its assigned IP address.

            - Because you can potentially create many pods that are running on many nodes,
                + it can be hard to identify them.
                + You can recognize and group pods by using string labels that you specify when you define a pod.


            1. Lifecycle of a Kubernetes pod
                - Kubernetes pods have a distinct lifecycle that affects the way you deploy, run, and update pods. 
                    + You start by submitting the pod YAML manifest to the cluster. 
                    + After the manifest file is submitted and persisted to the cluster, it defines the pod's desired state. 
                    + The scheduler schedules the pod to a healthy node that has enough resources to run the pod.

                - phases in a pod's lifecycle:
                    + Pending: The pod accepts the cluster, but not all containers in the cluster are set up or ready to run. 
                    + Running: The pod transitions to a running state after all of the resources within the pod are ready.
                    + Succeeded: The pod transitions to a succeeded state after the pod completes its intended task and runs successfully.
                    + Failed: Pods can fail for various reasons. 
                        - A container in the pod might fail, leading to the termination of all other containers, 
                        - or maybe an image wasn't found during preparation of the pod containers.

                    + Unknown: If the pod's state can't be determined.

                - Pods are kept on a cluster until a controller, the control plane, or a user explicitly removes them.
                    + When a pod is deleted, a new pod is created immediately after. 
                    + The new pod is considered an entirely new instance based on the pod manifest.
                    + It isn't an exact copy, so it differs from the deleted pod.

                - The cluster doesn't save the pod's state or dynamically assigned configuration. 
                    + For example, it doesn't save the pod's ID or IP address.
                        - This aspect affects how you deploy pods and how you design your apps. 
                            + For example, you can't rely on preassigned IP addresses for your pods.

            2. Container states: 
                - Keep in mind that the phases are a summary of where the pod is in its lifecycle. 
                    + When you inspect a pod, the cluster uses three states to track your containers inside the pod:
                        - Waiting: Default state of a container and the state that the container is in when it's not running or terminated.
                        - Running: The container is running as expected without any problems.
                        - Terminated: The container is no longer running. 
                            + The reason is that either all tasks finished or the container failed for some reason.
                                - A reason and exit code are available for debugging both cases.

3. How Kubernetes deployments work

    1. Pod deployment options: 4 options
        - 1. Pod templates
        - 2. Replication controllers
        - 3. Replica sets
        - 4. Deployments

        1. What is a pod template?
            - A pod template allows you to define the configuration of the pod you want to deploy.

            - A pod template contains information:
                + name of container image
                + container registry to use to fetch the images
            - A pod template includes runtime configuration information such as ports to use.
            - Templates are defined by using YAML in the same way as when create Docker files.
            - can use templates to deploy pods manually. 
                + However, a manually deployed pod isn't relaunched after it fails, is deleted, or is terminated.
            - To manage a pod's lifecycle, need to create a higher-level Kubernetes object.

        2. What is a replication controller?
            - A replication controller uses pod templates and defines a specified number of pods that must run.

            - The controller helps you run multiple instances of the same pod, and ensures pods are always running on one or more nodes in the cluster.
            - The controller replaces running pods in this way with new pods if they fail, are deleted, or are terminated.

            - For example, assume you deploy the drone-tracking front-end website, and users start accessing the website.
                + If all the pods fail for any reason, the website is unavailable to your users unless you launch new pods. 
                + A replication controller helps you make sure your website is always available.

        3. What is a replica set?
            - A replica set replaces the replication controller as the preferred way to deploy replicas. 

            - A replica set includes the same functionality as a replication controller, but it has an extra configuration option to include a selector value.
            - A selector enables the replica set to identify all the pods running underneath it.
                + Using this feature, you can manage pods labeled with the same value as the selector value, but not created with the replicated set.

        4. What is a deployment?
            - A deployment creates a management object one level higher than a replica set, and allows you to deploy and manage updates for pods in a cluster.

            - Assume that you have five instances of your app deployed in your cluster. 
                + There are five pods running version 1.0.0 of your app.
                + If you decide to update your app manually, you can remove all pods and then launch new pods running version 2.0.0 of your app.
                    - With this strategy, your app experiences downtime.
                + Instead, you want to execute a rolling update where you launch pods with the new version of your app before you remove the pods with the older app version.
                    - Rolling updates launch one pod at a time instead of taking down all the older pods at once.
                    - Deployments honor the number of replicas configured in the section that describes information about replica sets.
                    - It maintains the number of pods specified in the replica set as it replaces old pods with new pods.

            - Deployments, by default, provide a rolling update strategy for updating pods.
                + You can also use a re-create strategy. 
                    - This strategy terminates pods before launching new pods.

            - Deployments also provide you with a rollback strategy, which you can execute by using **kubectl**.

            - Deployments make use of YAML-based definition files and make it easy to manage deployments.
                + Keep in mind that deployments allow you to apply any changes to your cluster.
                + For example, you can deploy new versions of an app, update labels, and run other replicas of your pods.

            - **kubectl** has convenient syntax to create a deployment automatically when you're using the **kubectl run** command to deploy a pod. 
                + This command creates a deployment with the required replica set and pods.
                + However, the command doesn't create a definition file. 
                + It's a best practice to manage all deployments with deployment definition files and track changes by using a version-control system.

    2. Deployment considerations
        - Kubernetes has specific requirements about how you configure **networking** and **storage** for a cluster.
            + How you configure these two aspects affects your decisions about how to expose your apps on the cluster network and store data.

        - For example, each of the services in the drone-tracking app has specific requirements for user access, inter-process network access, and data storage.
        - let's take a look at these Kubernetes-cluster aspects and how they affect the deployment of apps.

        1. Kubernetes networking
            - Assume you have a cluster with one control plane and two nodes. 
                + When you add nodes to Kubernetes, an IP address is automatically assigned to each node from an internal private network range. 
                + For example, assume that your local network range is 192.168.1.0/24.
                    - Node 1: 192.168.1.10
                    - Node 2: 192.168.1.11

                + Each pod that you deploy gets assigned an IP from a pool of IP addresses.
                    - For example, assume that your configuration uses the 10.32.0.0/12 network range.
                        + Pod 1: 10.32.0.94
                        + Pod 2: 10.32.0.14

            - By default, the pods and nodes can't communicate with each other by using different IP address ranges.
            - To further complicate matters, recall that pods are transient. 
                + The pod's IP address is temporary and can't be used to reconnect to a newly created pod. 
                + This configuration affects how your app communicates to its internal components and how you and services interact with it externally.

            - To simplify communication, Kubernetes expects you to configure networking in such a way that:
                + Pods can communicate with one another across nodes without Network Address Translation (NAT).
                + Nodes can communicate with all pods, and vice versa, without NAT.
                + Agents on a node can communicate with all nodes and pods.

            - Kubernetes offers several networking options that you can install to configure networking.
                + Examples include *Antrea*, *Cisco Application Centric Infrastructure (ACI)*, *Cilium*, *Flannel*, *Kubenet*, *VMware NSX-T*, and *Weave Net*.

            - Cloud providers also provide their own networking solutions.
                + For example, Azure Kubernetes Service (AKS) supports the Azure Virtual Network container network interface (CNI), Kubenet, Flannel, Cilium, and Antrea.

    3. Kubernetes services
        - A Kubernetes service is a Kubernetes object that provides stable networking for pods.
            + A Kubernetes service enables communication between nodes, pods, and users of your app (both internal and external) to the cluster.

        - Kubernetes assigns a service an IP address on creation, just like a node or pod.
            + These addresses get assigned from a service cluster's IP range; for example, 10.96.0.0/12.
            + A service is also assigned a **DNS name** based on the **service name**, and an **IP port**.

        - In the drone-tracking app, network communication is as follows:
            + 1. The website and RESTful API are accessible to users outside the cluster.
            + 2. The in-memory cache and message queue services are accessible to the front end and the RESTful API, respectively, but not to external users.
            + 3. The message queue needs access to the data-processing service, but not to external users.
            + 4. The NoSQL database is accessible to the in-memory cache and data processing service, but not to external users.

        - In the drone-tracking app, you might decide to expose the **tracking website** and the **RESTful API** by using a **LoadBalancer** 
            + and the **data processing service** by using a **ClusterIP**.

        - To support these scenarios, you can configure **three types of services** to expose your app's components.
            + 1. **ClusterIP**:
                - The address assigned to a service that makes the service available to a set of services inside the cluster. 
                - For example, communication between the front-end and back-end components of your app.

            + 2. **NodePort**
                - The node port between 30000 and 32767 that the Kubernetes control plane assigns to the service; for example, 192.169.1.11 on clusters01.
                - You then configure the service with a target port on the pod that you want to expose. 
                - For example, configure port 80 on the pod running one of the front ends. 
                    + You can now access the front end through a **node IP and port address**.

            + 3. **LoadBalancer**
                - The load balancer that allows for the distribution of load between nodes running your app, and exposing the pod to public network access. 
                - You typically configure load balancers when you use cloud providers.
                    + In this case, traffic from the external load balancer is directed to the pods running your app.

    4. How to group pods: **service Selector label** and **pod Labels**
        - Managing pods by IP address isn't practical. 
        - Pod IP addresses change as controllers re-create them, and you might have any number of pods running.

        - A **service object** allows you to target and manage specific pods in your cluster by using **selector labels**.
            + You set the **selector label** in a service definition to match the **pod label** defined in the pod's definition file.

            + For example, assume that you have many running pods. 
                - Only a few of these pods are on the front end, and you want to set a LoadBalancer service that targets only the front-end pods. 
                - You can apply your service to expose these pods by referencing the pod label as a selector value in the service's definition file.
                - The service groups only the pods that match the label. 
                - If a pod is removed and re-created, the new pod is automatically added to the service group through its matching label.

        - Ex: drone-tracking app
            ```
            Cluster Node - 192.168.1.10
                --> Website
                    10.96.0.1:80 drone-front-end-service
                    Selector:
                        app: front-end-nginx

                    --> Pod 10.32.0.94:80
                        Labels:
                            app: front-end-nginx
                    --> Pod 10.32.0.97:80
                        Labels:
                            app: front-end-nginx

                --> Website + MongoDB
                    Pod 10.32.0.95:27017
                    Labels:
                        app: back-end-db
            ```

    5. Kubernetes storage
        - Kubernetes uses the same storage volume concept that you find when using Docker.
            + Docker volumes are less managed than the Kubernetes volumes, because Docker volume lifetimes aren't managed.
            + The Kubernetes volume's lifetime is an explicit lifetime that matches the pod's lifetime. 
                - This lifetime match means a volume outlives the containers that run in the pod.
                - However, if the pod is removed, so is the volume.

        
        - Kubernetes provides options to provision persistent storage with the use of **PersistentVolumes**. 
            + You can also request specific storage for pods by using **PersistentVolumeClaims**.
            + **Pod volumes** and **Persistant volumes**

        - Keep both of these options in mind when you're deploying app components that require persisted storage, like message queues and databases.

    6. Cloud integration considerations
        - Kubernetes doesn't dictate the technology stack you use in your cloud-native app. 
            + In a cloud environment such as Azure, you can use several services outside the Kubernetes cluster.

        - Kubernetes doesn't provide any of the following services: 
            + Middleware
            + Data-processing frameworks
            + Databases
            + Caches
            + Cluster storage systems

        - In this drone-tracking solution, there are three services that provide middleware functionality: 
            + a NoSQL database
            + an in-memory cache service
            + and a message queue. 
        
        - You might select:
            + MongoDB Atlas for the NoSQL solution
            + Redis to manage in-memory cache 
            + and RabbitMQ or Kafka depending on your message-queue needs

        - When you're using a cloud environment such as Azure, it's a best practice to use services outside the Kubernetes cluster.
            + This decision can simplify the cluster's configuration and management. 
            + For example, 
                + you can use **Azure Cache for Redis** for the **in-memory caching services**, 
                + **Azure Service Bus messaging** for the **message queue**, 
                + and **Azure Cosmos DB** for the **NoSQL database**.

4. Exercise - Explore the functionality of a Kubernetes cluster
    - Linux, Mac, and Windows
    - Several options are available when you're running Kubernetes locally
        + 1. install Kubernetes on physical machines 
        + 2. or VMs
        + 3. or use a cloud-based solution such as Azure Kubernetes Service (AKS).

    - Your goal in this exercise is to explore a Kubernetes installation with a **single-node cluster**.
        + learn how to configure and install a **MicroK8s** environment that's easy to set up and tear down.
            - Then, you deploy a Kubernetes service and scale it out to multiple instances to host a website.

        + other options such as **MiniKube** and **Kubernetes support in Docker**

    1. What is MicroK8s?
        - MicroK8s is an option for deploying a single-node Kubernetes cluster as a single package to target workstations and Internet of Things (IoT) devices. 
        - You can install MicroK8s on Linux, Windows, and macOS.

        1. Install MicroK8s on Windows
            - To run MicroK8s on Windows, use **Multipass**. **Multipass** is a **lightweight VM manager** for Linux, Windows, and macOS.

            - 1. Step 1. Download and install the latest release of Multipass for Windows from GitHub.
                - https://github.com/canonical/multipass/releases

            - 2. Step 2. In a command console, run the **Multipass** launch command to configure and run the **microk8s-vm** image.
                ``` console
                multipass launch --name microk8s-vm --memory 4G --disk 40G
                ```
                + take a few minutes to complete, depending on the speed of your internet connection and desktop.

            - 3. Step 3. After you receive the launch confirmation for microk8s-vm, run the **multipass shell microk8s-vm** command to access the VM instance.
                ```console
                multipass shell microk8s-vm
                ```
                - Once multipass is working, you can access the Ubuntu VM to host your cluster and install MicroK8s.

            - 4. step 4. Install the MicroK8s snap app. 
                ```
                sudo snap install microk8s --classic

                    --> 2020-03-16T12:50:59+02:00 INFO Waiting for restart...
                        microk8s v1.17.3 from Canonical✓ installed
                ```
                + This step might take a few minutes to complete, depending on the speed of your internet connection and desktop

            - **NEXT**: You're now ready to install add-ons on the cluster.

    2. Prepare the cluster
        - To view the status of the installed add-ons on your cluster, run the **status command** in MicroK8s. 
            + These add-ons provide several services, some of which you covered previously. 
            + One example is DNS functionality.

        - 1. Step 1: To check the status of the installation, run the **microk8s.status --wait-ready** command.
            ```
            sudo microk8s.status --wait-ready
            ```
            - Notice that there are several disabled add-ons on your cluster. Don't worry about the add-ons that you don't recognize.

        - 2. Step 2: From the list, you need to enable the DNS, Dashboard, and Registry add-ons. Here are the purposes of each add-on:
            1. **DNS**: Deploys the **coreDNS** service.
            2. **Dashboard**: Deploys the **kubernetes-dashboard** service and several other services that support its functionality.
                - It's a general-purpose, web-based UI for Kubernetes clusters.
            3. **Registry**: Deploys a private registry and several services that support its functionality. 
                - To store private containers, use this registry.

            + To install the add-ons, run the following command.
                ```
                sudo microk8s.enable dns dashboard registry
                ```

        - **NEXT**: You're now ready to access your cluster with **kubectl**.

    3. Explore the Kubernetes cluster
        - **MicroK8s** provides a version of **kubectl** that you can use to interact with your new Kubernetes cluster.
            + This copy of **kubectl** allows you to have a parallel installation of another **system-wide kubectl** instance without affecting its functionality.
        
        - to alias **microk8s.kubectl** to **kubectl**:
            ```Bash
            sudo snap alias microk8s.kubectl kubectl

                --> Added:
                      - microk8s.kubectl as kubectl
            ```

        1. Display cluster node information
            - Recall from earlier that a Kubernetes cluster exists out of control planes and worker nodes. 
                + Let's explore the new cluster to see what's installed.
                
            1. Check the nodes that are running in your cluster
                ```Bash
                sudo kubectl get nodes
                ```
                - MicroK8s is a single-node cluster installation, so you expect to see only one node. 
                    + Keep in mind, though, that this node is both the **control plane** and a **worker node** in the cluster.

                - To fetch extra information from the API server, pass **-o wide** parameter:
                    ```
                    sudo kubectl get nodes -o wide
                    ```
                    + Notice: node's internal IP address, the OS running on the node, the kernel version, and the container runtime
            
            2. to explore the services running on your cluster
                ```
                sudo kubectl get services -o wide
                ```
                - Notice: only one service is listed
                    + The reason for the single service listing is that Kubernetes uses a concept called **namespaces** to logically divide a cluster into multiple virtual clusters.

                - To fetch all services in all namespaces, pass the **--all-namespaces** parameter:
                    ```
                    sudo kubectl get services -o wide --all-namespaces
                    ```
                    + three namespaces in your cluster: 
                        - **default**
                        - **container-registry**
                        - **kube-system**
                    + see the **registry**, **kube-dns**, and **kubernetes-dashboard** instances that you installed

                - **Next**: Now that you can see the services running on the cluster, you can schedule a workload on the worker node.

        2. Install a **web server** on a cluster
            - You want to schedule a web server on the cluster to serve a website to your customers. 
                + You can choose from several options. 
                + For this example, you use **NGINX**.

            - Recall from earlier that you can use **pod manifest files** to describe your pods, replica sets, and deployments to define workloads.
                + Because you haven't covered these files in detail, you run **kubectl** to directly pass the information to the API server.

            - Even though the use of kubectl is handy, using **manifest files** is a best practice. 
                + **Manifest files** allow you to roll forward or roll back deployments with ease in your cluster.
                + These files also help document a cluster's configuration.

            1. To create your NGINX deployment
                ```
                sudo kubectl create deployment nginx --image=nginx
                    result: deployment.apps/nginx created
                ```
                - Specify the name of the deployment and the container image to create a single instance of the pod.

            2. To fetch the information about your deployment
                ```
                sudo kubectl get deployments
                ```

            3. The deployment created a pod. To fetch info about your cluster's pods
                ```
                sudo kubectl get pods

                    --> Name: nginx-86c57db685-dj6lz
                ```
                - Notice that the **name of the pod** is a generated value prefixed with the name of the deployment, and the pod has a status of Running.

        3. Test the website installation
            - Test the NGINX installation by connecting to the web server through the **pod's IP address**.
            1. To find the pod's address, pass the -o wide parameter:
                ```
                sudo kubectl get pods -o wide
                    --> Name: nginx-86c57db685-dj6lz, IP address: 10.1.83.10   
                ```
                - Notice that the command returns both the **IP address of the node**, and the **node name** on which the workload is scheduled.

            2. To access the website, run **wget** on the IP listed before:
                ```
                wget <POD_IP>
                    wget 10.1.83.10
                ```

        4. Scale a web server deployment on a cluster
            - Assume that you suddenly see an increase in users who access your website, and the website starts failing because of the load.
                + You can deploy more instances of the site in your cluster and split the load across the instances.

            - To scale the number of replicas in your deployment, run the kubectl scale command. 
                + You specify the number of replicas you need and the name of the deployment.

            1. To scale the total of NGINX pods to three, run the kubectl scale command:
                ```
                sudo kubectl scale --replicas=3 deployments/nginx
                    --> result: deployment.apps/nginx scaled
                ```

            2. To check the number of running pods, run the **kubectl get** command, and again pass the **-o wide** parameter:
                ```
                sudo kubectl get pods -o wide
                    --> nginx-86c57db685-dj6lz  10.1.83.10
                    --> nginx-86c57db685-lzrwp  10.1.83.12   
                    --> nginx-86c57db685-m7vdd  10.1.83.11   
                ```
                - Notice that you now see three running pods, each with a unique IP address

            - You'd need to apply several more configurations to the cluster to effectively expose your website as a public-facing website.
                + Examples include installing a load balancer and mapping node IP addresses.

5. When to use Kubernetes
    - The decision to use a container orchestration platform like Kubernetes depends on business and development requirements. 
        + Here's a review of the high-level architecture of the drone tracking solution.

    - The solution is built as microservices that are designed as loosely coupled, collaborative services. 
        + To simplify the solution's design and maintenance, you're deploying these services separately from each other.

    - Here's the current configuration of your solution.
        ```
        User <--> Web front-end <--> Azure Cache for Redis --> Azure Cosmos DB
        Restful API --> Azure Service Bus messing --> Processing Service --> Azure Cosmos DB
        ```
        + **Web front-end**: Shows maps and information about tracked drones.
        + **Cache service**: Stores frequently requested information appearing on the website.
        + **RESTful API**: Used by tracked drones to send data about their status, such as a GPS location and battery-charge levels.
        + **Queue**: Holds unprocessed data collected by the RESTful API.
        + **Data-processing service**: Fetches and processes data from the queue.
        + **NoSQL database**: Stores processed tracking data and user information captured from the website and the data-processing service.

    - Separate teams in your company develop and own these services. 
        + Each team uses containers to build and deploy its service. 
        + This new strategy allows the development teams to keep up with the requirements of modern software development for automation, testing, and overall stability and quality.

    - The change in developer requirements has resulted in several process and business benefits for the company.
        + Examples include better use of hosted compute resources, new features that have improved time to market, and improved customer reach.

    - However, several challenges with container management led your company to investigate container-orchestration solutions. 
        + Your teams found that scaling the tracking application to a handful of deployments was relatively easy, but scaling and managing many instances was hard.

    - There are several other aspects to consider.
        + Examples include dealing with **failed containers**, **storage allocation**, **network configuration**, and managing **app secrets**.

    - Kubernetes provides support for all of these challenges as an orchestration platform.

    - You want to use Kubernetes when your company:
        1. Develops apps as microservices.
        2. Develops apps as cloud-native applications.
        3. Deploys microservices by using containers.
        4. Updates containers at scale.
        5. Requires centralized container networking and storage management.

    1. When not to use Kubernetes
        - Not all applications need to run in Kubernetes. As a result, Kubernetes might not be a good fit for your company.

        - For example, the effort in containerizing and deploying a monolithic app might be more than the benefits of running the app in Kubernetes. 
            + A monolithic architecture can't easily use features such as individual component scaling or updates.

        - Kubernetes can introduce many business benefits for software development, deployment, management, and streamlining of processes.
            + However, Kubernetes has a steep learning curve.
            + The modular design of Kubernetes introduces potentially new concepts that affects teams across your company.

        - Your development teams have to embrace modern design concepts when developing and designing apps. 
            + These concepts include using microservices and containerizing these services. 
            + Teams also need to experiment with container and orchestration environments to make the best use of all the available options.

6. Summary
    - Kubernetes provides for:
        1. Deploying containers.
        2. Self-healing containers.
        3. Dynamically scaling container count up or down.
        4. Automated rolling updates and rollbacks of containers.
        5. Managing storage.
        6. Managing network traffic.
        7. Storing and managing sensitive information such as usernames and passwords.

7. Uninstall MicroK8s
    - To recover space on your development machine, you can remove everything you've deployed so far, even the VM.

    1. To remove the add-ons from the cluster, run the microk8s.disable command, and specify the add-ons to remove:
        ```Bash
        sudo microk8s.disable dashboard dns registry
        ```

    2. To remove MicroK8s from the VM, run the **snap remove** command:
        ``` Bash
        sudo snap remove microk8s
        ```

    3. to remove the Multipass VM manager from your machine, there are a few extra steps to take on Windows and macOS
        1. To exit the VM, run the exit command
            ```Bash
            exit
            ```

        2. To stop the VM, run the **multipass stop** command and specify the VM's name:
            ```Bash
            multipass stop microk8s-vm
            ```

        3. To delete and purge the VM instance, run **multipass delete**, then run **multipass purge**:
            ```Console
            multipass delete microk8s-vm
            multipass purge
            ```

8. Learn More
    - To learn more about Kubernetes, running Kubernetes on Azure, and related tools
        + Kubernetes: https://kubernetes.io/
        + Azure Kubernetes Service: https://azure.microsoft.com/products/kubernetes-service/
        + MicroK8s: https://microk8s.io/
        + Multipass GitHub repository: https://github.com/canonical/multipass/releases

### Introduction to Azure Kubernetes Service

1. What is Azure Kubernetes Service?
    1. What is a container?
    2. Why use a container?
        - Suppose your asset-tracking solution included three major applications:
            + A tracking website that includes maps and information about the assets being tracked
            + A data processing service that collects and processes information sent from tracked assets
            + An MSSQL database for storing customer information captured from the website
        - You realize that to meet customer demand, you have to scale out your solution.

        1. Virtual Machines (VMs)
            - One option is to deploy a new virtual machine for every application, hosted across multiple regions. 
                + Then, copy the applications to your new VMs.
                + However, doing so makes you responsible for managing each VM that you use.
            - The maintenance overhead increases as you scale. 
                + You need to provision and configure VM operating system (OS) versions and dependencies for each application to match. 
                + When you apply upgrades for your applications that affect the OS and major changes, there are precautions. 
                + If any errors appear during the upgrade, you need to roll back the installation, which causes disruption such as downtime or delays.

            - The container concept gives us four major benefits:
                + Immutability
                + Smaller Size
                + Lightweight
                + Startup is fast

    3. What is container management?
        - For example, suppose that you discover that at noon there's more site traffic, 
            + so you need more instances of the site's caching service to manage performance. 
            + You plan to solve this problem by adding more caching service containers.

        - Now it's time to roll out a new version of your caching service. 
            + How do you update all the containers? 
            + How do you remove all the older versions?

    4. What is Kubernetes?
    5. What is the Azure Kubernetes Service (AKS)?
        - AKS manages your hosted Kubernetes environment and makes it simple to deploy and manage containerized applications in Azure.
            + Your AKS environment is enabled with features such as automated updates, self-healing, and easy scaling.
            + Azure manages your Kubernetes cluster's control plane for free. 
            + You manage the agent nodes in the cluster and only pay for the VMs on which your nodes run.

        - You can create and manage your cluster in the Azure portal or with the Azure CLI. 
            + When you create the cluster, there are Resource Manager templates to automate cluster creation. 
            + With these templates, you have access to features such as advanced networking options, Microsoft Entra Identity, and resource monitoring. 
            + Then, you can set up triggers and events to automate the cluster deployment for multiple scenarios.

2. How Azure Kubernetes Service works
    1. Create an AKS cluster
        - you'll configure:
            + The Kubernetes cluster name.
            + The version of Kubernetes to install.
            + A DNS prefix to make the control plane node publicly accessible.
            + The initial node pool size.

        - The initial node pool size defaults to two nodes, but we recommend that you use at least three nodes for a production environment.
        - The control-plane node in your cluster is free. 
            + You only pay for node **VMs**, **storage**, and **networking resources** consumed in your cluster.

    2. How workloads are developed and deployed to AKS
        - AKS supports the Docker image format. 
            + With a Docker image, you can use any development environment to create a workload, package the workload as a container, and deploy the container as a Kubernetes pod.

        - AKS also supports popular development and management tools such as 
            + **Helm**
            + **Draft**
            + Kubernetes extension for Visual Studio Code
            + Visual Studio Kubernetes Tools.

    3. Bridge to Kubernetes
        - Bridge to Kubernetes allows you to run and debug code on your development computer while still being connected to your Kubernetes cluster and the rest of your application or services.

        - With Bridge to Kubernetes, you can:
            + Avoid having to build and deploy code to your cluster. 
                - Instead, you create a direct connection from your development computer to your cluster. 
                - That connection allows you to quickly test and develop your service in the context of the full application without creating a Docker or Kubernetes configuration for that purpose.
            + Redirect traffic between your connected Kubernetes cluster and your development computer.
            + Replicate environment variables and mounted volumes available to pods in your Kubernetes cluster to your development computer. 

    4. Azure Service Integration
        - AKS allows you to integrate any Azure service offering and use it as part of an AKS cluster solution.

        - For example, remember that Kubernetes doesn't provide middleware and storage systems.
            + Suppose you need to add a processing queue to the fleet management data processing service.
            + You can easily integrate Azure Storage queues to extend the capacity of the data processing service.

3. When to use Azure Kubernetes Service
    - You can either approach your decision from a **green fields** or a **lift-and-shift** project point of view. 
        + A **green fields** project allows you to evaluate AKS based on default features. 
        + A **lift-and-shift** project forces you to look at which features are best suited to support your migration.

    - List out Azure resources you should consider to enhance your AKS Kubernetes offering:
        1. Identity and security management
            - Do you already use existing Azure resources and make use of Microsoft Entra ID? 
                + You can configure an AKS cluster to integrate with Microsoft Entra ID and reuse existing identities and group membership.

        2. Integrated logging and monitoring
            - AKS includes Azure Monitor for containers to provide performance visibility into the cluster. 

        3. Auto Cluster node and pod scaling
            - Deciding when to scale up or down in a large containerization environment is tricky.
                + AKS supports two auto cluster scaling options. 
                + You can use either the **horizontal pod autoscaler** or the **cluster autoscaler** to scale the cluster. 
                + The **horizontal pod autoscaler** watches the resource demand of pods and increases pod resources to match demand. 
                + The **cluster autoscaler** component watches for pods that can't be scheduled because of node constraints. 
                + It automatically scales cluster nodes to deploy scheduled pods.

        4. Cluster node upgrades
            - Do you want to reduce the number of cluster-management tasks?
                +  AKS manages Kubernetes software upgrades and the process of cordoning off nodes and draining them to minimize disruption to running applications.
                + Once done, these nodes are upgraded one at a time.

        5. GPU enabled nodes
            - Do you have compute-intensive or graphic-intensive workloads? 
                + AKS supports GPU-enabled node pools.

        6. Storage volume support
            - Is your application stateful, and does it require persisted storage? 
                + AKS supports both static and dynamic storage volumes.
                + Pods can attach and reattach to these storage volumes as they're created or rescheduled on different nodes.

        7. Virtual network support
            - Do you need pod-to-pod network communication or access to on-premises networks from your AKS cluster? 
                + An AKS cluster can be deployed into an existing virtual network with ease.

        8. Ingress with HTTP application-routing support
            - Do you need to make your deployed applications publicly available? 
                + The HTTP application-routing add-on makes it easy to access AKS cluster deployed applications.

        9. Docker image support
            - Do you already use Docker images for your containers? 
                + AKS supports the Docker file image format by default.

        10. Private container registry
            - Do you need a private container registry? 
                + AKS integrates with Azure Container Registry (ACR). 
                + You aren't limited to ACR; you can use other container repositories, whether public or private.

    - All of these features are configurable, either when you create the cluster or following deployment.

## Part 2: Azure Kubernetes Service (AKS) cluster architecture and operations
- https://learn.microsoft.com/en-us/training/paths/aks-cluster-architecture/

## Part 3: Azure Kubernetes Service (AKS) application and cluster scalability
- https://learn.microsoft.com/en-us/training/paths/aks-cluster-scalability/

## Learning path: Develop and deploy applications on Kubernetes
- https://learn.microsoft.com/en-us/training/paths/develop-deploy-applications-kubernetes/
- In this learning path, you'll understand how to develop, build, deploy, and automatically maintain cloud native applications designed to work with Azure Kubernetes Service from the scratchpad to the deployment pipeline.

### Deploy a containerized application on Azure Kubernetes Service
- https://learn.microsoft.com/en-us/training/modules/aks-deploy-container-app

1. Create an Azure Kubernetes Service cluster
    1. Kubernetes clusters
        - Kubernetes is based on clusters. 
          + Instead of having a single virtual machine (VM), it uses several machines working as one. 
            - These VMs are called nodes. 
          + Kubernetes is a cluster-based orchestrator. 
            - It provides your application with several benefits, such as availability, monitoring, scaling, and rolling updates.

    2. Cluster nodes
        - A cluster is node-based. There are two types of nodes in a Kubernetes cluster that provide specific functionality.
          + Control plane nodes
          + Nodes

    3. Cluster architectures
        - Use a cluster architecture to conceptualize the number of control planes and nodes you deploy in your Kubernetes cluster.

    4. Single control plane and multiple nodes
        - The single control plane to multiple nodes per cluster architecture is the most common architectural pattern and is the easiest to deploy, 
            + but it doesn't provide high availability to your cluster's core management services.

        - If the control plane node becomes unavailable for any reason, no other interaction can happen with the cluster.
          + This problem occurs even if you're the operator, or by any workloads that use Kubernetes' APIs to communicate until, at least, the API server is back online.

        - If you're dealing with a production scenario, this architecture might not be the best solution.

    5. Single control plane and a single node
        - The single control plane to single node architecture is a variant of the previous architecture and is used in development environments.
        - The single control plane and single node architecture limits cluster scaling and makes this architecture unsuitable for **production** and **staging** use.

    6. Configure an AKS cluster
        - When you create a new AKS cluster, you have several different items to configure.
        - Each item affects the final configuration of your cluster for compute resource allocation.
        - These items include:
            + 1. Node pools
            + 2. Node count
            + 3. Node VM size

        1. Node pools
            - You create node pools to group nodes in your AKS cluster. 
              + When you create a node pool, you specify the VM size and OS type (Linux or Windows) for each node in the node pool based on application requirement. 
              + To host user application pods, node pool **Mode** should be **User** otherwise **System**.

            - By default, an AKS cluster has a Linux node pool (**System Mode**) whether you create it through the Azure portal or CLI.
              + However, you can configure it to add *Windows node pools* along with *default Linux node pools* during the creation wizard in the portal, parameters in CLI, or with ARM templates.

            - Node pools use **Virtual Machine Scale Sets** as the underlying infrastructure to allow the cluster **to scale the number of nodes in a node pool**. 
              + New nodes created in the node pool are always the same size as you specified when you created the node pool.

        2. Node count
            - The node count is the number of nodes your cluster has in a node pool. 
              + Nodes are Azure VMs. 
              + You can change their size and count to match your usage pattern.

            - You can change the node count later in the cluster's configuration panel. 
              + It's also a best practice to keep this number as low as possible to avoid unnecessary costs and unused compute power.

        3. Node VM size
            - Select from a wide range of VM specs. 
              + For development purposes, you can choose the B series to save on costs.
              + In the exercises, you use series B2, the standard size.

            - For more guidance to select a VM based on your needs, ask **Microsoft Copilot in Azure to find the best VM**
              + For more guidance to select a VM based on your needs, ask Microsoft Copilot in Azure to find the best VM

2. Exercise - Create an Azure Kubernetes Service cluster: Linux & Windows
    - Step 1: Create variables for the configuration values you reuse throughout the exercises
      ```Bash
      export RESOURCE_GROUP=rg-contoso-video
      export CLUSTER_NAME=aks-contoso-video
      export LOCATION=eastus
      ```

    - Step 2: Run the **az group create** command to create a resource group. Deploy all resources into this new resource group.
      ```Bash
      az group create --name=$RESOURCE_GROUP --location=$LOCATION
      ```

    - Step 3: Run the **az aks create** command to create an AKS cluster
      ```Bash
      az aks create --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --node-count 2 --generate-ssh-keys --node-vm-size Standard_B2s --network-plugin azure --windows-admin-username localadmin
      ```
      + The command creates a new AKS cluster named **aks-contoso-video** within the **rg-contoso-video** resource group. 
        - The cluster has two nodes defined by the -**-node-count** parameter.
        - The **--node-vm-size** parameter configures the cluster nodes as Standard_B2s-sized VMs.
        - These nodes are part of **System mode**.

      + IMPORTANT: Standard B2s VMs are required to create node pools but not available in Free-Tier subscriptions.
        - If you're receiving notifications about limits, you need to upgrade to a Standard Upgrade

      + The **--windows-admin-username** parameter is used to set up administrator credentials for Windows containers, and prompts the user to set a password at the command line. 
        - The password has to meet **Windows Server password requirements**.

    - Step 4: Run the **az aks nodepool add** command to add another node pool that uses the Windows operating system
      ```Azure CLI
      az aks nodepool add --resource-group $RESOURCE_GROUP --cluster-name $CLUSTER_NAME --name uspool --node-count 2 --node-vm-size Standard_B2s --os-type Windows
      ```
      + The command adds a new node pool (**User mode**) to the existing AKS cluster (created in the previous command).
        - This User node pool is used to host applications and workloads, unlike the **System** node pool.

      + The **--os-type** parameter is used to specify operating system of the node pool. 
        - If not specified, the command uses Linux as operating system for the nodes.

    1. Link with kubectl
        - Step 1: Link your Kubernetes cluster with kubectl by running the following command in Cloud Shell.
          ```Azure CLI
          az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
          ```
          + This command adds an entry to your **~/.kube/config** file, which holds all the information to access your clusters.
            - Kubectl enables you to manage multiple clusters from a single command-line interface.

        - Step 2: Run the kubectl get nodes command to check that you can connect to your cluster, and confirm its configuration.
          ```Bash
          kubectl get nodes
          ```

          ```output
          NAME                                STATUS   ROLES   AGE    VERSION
          aks-nodepool1-40010859-vmss000000   Ready    agent   245s   v1.23.12
          aks-nodepool1-40010859-vmss000001   Ready    agent   245s   v1.23.12
          aksuspool000000                     Ready    agent   105s   v1.23.12
          aksuspool000001                     Ready    agent   105s   v1.23.12
          ```

3. Deploy an application on your Azure Kubernetes Service cluster
    1. What is a container registry?
    2. What is a Kubernetes pod?
    3. What is Kubernetes deployment?
    4. Kubernetes manifest files
    5. What is a Kubernetes label?
    6. The structure of a manifest file
    7. Group objects in a deployment
    8. Apply a deployment file

4. Exercise - Deploy an application on your Azure Kubernetes Service cluster

    1. Create a deployment manifest
        1. In Cloud Shell, create a manifest file for the Kubernetes deployment called **deployment.yaml** by using the integrated editor.
            ```Bash
            touch deployment.yaml
            ```

            ```yml
            # deployment.yaml
            apiVersion: apps/v1 # The API resource where this workload resides
            kind: Deployment # The kind of workload we're creating
            metadata:
              name: contoso-website # This will be the name of the deployment
            ```

            - First two keys to tell Kubernetes the **apiVersion** and **kind** of manifest you're creating.
              + For more information about **apiVersion** and what values to put in this key, see the official Kubernetes documentation

            - The **name** is the name of the deployment. 
              + Use it to identify and query the deployment information when you use **kubectl**.

        2. A deployment wraps a pod. 
            - You make use of a template definition to define the pod information within the manifest file. 
            - The template is placed in the manifest file under the deployment specification section.
            ```yml
            # deployment.yaml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: contoso-website
            spec:
              template: # This is the template of the pod inside the deployment
                metadata: # Metadata for the pod
                  labels:
                    app: contoso-website
            ```

            - Pods don't use the same names as the deployments. 
              + The pod's name is a mix of the deployment's name with a random ID added to the end.

            - NOTICE the use of the **labels** key. 
              + You add the **labels** key to allow deployments to find and group pods.

        3. A pod wraps one or more containers. 
            - All pods have a specification section that allows you to define the containers inside that pod.

            ```yml
            # deployment.yaml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: contoso-website
            spec:
              template: # This is the template of the pod inside the deployment
                metadata:
                  labels:
                    app: contoso-website
                spec:
                  containers: # Here we define all containers
                    - name: contoso-website
            ```
            - The **containers** key is an array of container specifications because a pod can have one or more containers. 
              + The specification defines an **image**, a **name**, **resources**, **ports**, and other important information about the container.

            - All running pods follow the name **contoso-website-<UUID>**, where UUID is a generated ID to identify all resources uniquely.

        4. It's a good practice to define a minimum and a maximum amount of resources that the app is allowed to use from the cluster.
            - You use the **resources** key to specify this information.

            ```yml
            # deployment.yaml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: contoso-website
              spec:
                template: # This is the template of the pod inside the deployment
                  metadata:
                    labels:
                      app: contoso-website
                  spec:
                    containers:
                      - image: mcr.microsoft.com/mslearn/samples/contoso-website
                        name: contoso-website
                        resources:
                          requests: # Minimum amount of resources requested
                            cpu: 100m
                            memory: 128Mi
                          limits: # Maximum amount of resources requested
                            cpu: 250m
                            memory: 256Mi
            ```
            - NOTICE how the resource section allows you to specify 
              + the `minimum resource amount as a request` 
              + and the `maximum resource amount as a limit`.

        5. The last step is to define the ports this container exposes externally through the **ports** key. 
            - The **ports** key is an array of objects, which means that a container in a pod can expose multiple ports with multiple names.

            ```yml
            # deployment.yaml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: contoso-website
            spec:
              template: # This is the template of the pod inside the deployment
                metadata:
                  labels:
                    app: contoso-website
                spec:
                  nodeSelector:
                    kubernetes.io/os: linux
                  containers:
                    - image: mcr.microsoft.com/mslearn/samples/contoso-website
                      name: contoso-website
                      resources:
                        requests:
                          cpu: 100m
                          memory: 128Mi
                        limits:
                          cpu: 250m
                          memory: 256Mi
                      ports:
                        - containerPort: 80 # This container exposes port 80
                          name: http # We named that port "http" so we can refer to it later
            ```
            - NOTICE how you name the port by using the **name** key. 
              + Naming ports allows you to change the exposed port without changing files that reference that port.

        6. Finally, add a selector section to define the workloads the deployment manages. 
            - The **selector** key is placed inside the deployment specification section of the manifest file. 
            - Use the **matchLabels** key to list the labels for all the pods managed by the deployment.

            ```yml
            # deployment.yaml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: contoso-website
            spec:
              selector: # Define the wrapping strategy
                matchLabels: # Match all pods with the defined labels
                  app: contoso-website # Labels follow the `name: value` template
              template: # This is the template of the pod inside the deployment
                metadata:
                  labels:
                    app: contoso-website
                spec:
                  nodeSelector:
                    kubernetes.io/os: linux
                  containers:
                    - image: mcr.microsoft.com/mslearn/samples/contoso-website
                      name: contoso-website
                      resources:
                        requests:
                          cpu: 100m
                          memory: 128Mi
                        limits:
                          cpu: 250m
                          memory: 256Mi
                      ports:
                        - containerPort: 80
                          name: http
            ```

            - NOTICE: In an AKS cluster which has multiple node pools (Linux and Windows), the deployment manifest file previously listed also defines a **nodeSelector** to tell your AKS cluster to run the sample application's pod on a node that can run Linux containers.
            - Linux nodes can't run Windows containers and vice versa.

    2. Apply the manifest
        1. In Cloud Shell, run the **kubectl apply** command to submit the deployment manifest to your cluster
            ```Bash
            kubectl apply -f ./deployment.yaml

              --> output
              deployment.apps/contoso-website created 
            ```

        2. Run the **kubectl get deploy** command to check if the deployment was successful
            ```Bash
            kubectl get deploy contoso-website

              --> output
              NAME              READY   UP-TO-DATE   AVAILABLE   AGE
              contoso-website   0/1     1            0           16s
            ```

        3. Run the **kubectl get pods** command to check if the pod is running
            ```Bash
            kubectl get pods

              --> output
              NAME                               READY   STATUS    RESTARTS   AGE
              contoso-website-7c58c5f699-r79mv   1/1     Running   0          63s
            ```

5. Summary

6. Clean up resources
    1. Delete resource group: `rg-contoso-video`
    2. Run the **kubectl config delete-context** command to remove your deleted clusters context
        ```
        kubectl config delete-context aks-contoso-video

            --> deleted context aks-contoso-video from /home/user/.kube/config
        ```

7. Learn more
    - AKS documentation: https://learn.microsoft.com/en-us/azure/aks/
    - Introduction to AKS: https://learn.microsoft.com/en-us/training/modules/intro-to-azure-kubernetes-service/
    - Prepare an application for AKS: https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-app
    - Deploy an AKS cluster: https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster
    - HTTP application routing: https://learn.microsoft.com/en-us/azure/aks/http-application-routing
    - Azure CLI documentation: https://learn.microsoft.com/en-us/azure/aks/kubernetes-walkthrough
    - Azure CLI command docs: https://learn.microsoft.com/en-us/cli/azure/aks/#az-aks-create
    - AKS HTTPS ingress controller docs: https://learn.microsoft.com/en-us/azure/aks/ingress-tls
    - Kubernetes ingress controllers: https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
    - Kubernetes documentation: https://kubernetes.io/docs/home/
    - Kubernetes service types: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
    - Azure Kubernetes Service (AKS) Production Baseline:
      + https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks

### Application and package management using Helm
- https://learn.microsoft.com/en-us/training/modules/aks-app-package-management-using-helm/
- https://github.com/Azure-Samples/aks-store-demo.git

0. Introduction
    1. Introduction
    2. Example scenario
        - Let's say you work for a major pet store company called Contoso Pet Supplies. 
            + Your company sells pet supplies to customers worldwide.
        
        - The solution is built and deployed as microservices and includes several major applications:
            ```
            Customers --> store-front (View) --> order-service (NodeJS) --> Order Queue (RabbitMQ)
                                             --> product-service (R)

            Employees --> store-admin (View) --> makeline-service (GO) --> Order Database (mongoDB)
                                                                       --> Order Queue (RabbitMQ)
                                             --> product-service (R)
            ```
            ![Contoso Pet Supplies](./assets/Application%20and%20package%20management%20using%20Helm/Contoso%20Pet%20Supplies.png)

        - You use an Azure Kubernetes Service (AKS) cluster to host the pet store front solution. 
            + The DevOps team uses standard declarative YAML files to deploy various services in the solution. 
            + In the current deployment workflow, the development teams create the deployment files for each application. 
            + Next, the DevOps team updates the deployment files to reflect production configuration settings where required. 
            + The manual management of many YAML files is proving a risk to the teams when efficiently deploying, operating, and maintaining systems and procedures. 
            + The DevOps team wants to use a Kubernetes package manager to standardize, simplify, and implement reusable deployment packages for all apps in the store front solution.

        - How to create and manage a Kubernetes releases using Helm as a Kubernetes package manager.

1. Helm basics
    - When deploying, versioning, and updating applications, you need to ensure you have the correct versions of software libraries and configurations so that the application functions as expected.

    - Let's say your development team decides to deploy the pet store company website to Kubernetes. 
        + As part of the process, your team creates deployment, service, and ingress YAML-based files. 
        + You hardcode and maintain the information in each file for each target environment by hand. 
        + However, maintaining three files for each environment is cumbersome and increases in complexity as the application grows.

    - You can use Helm to simplify the application deployment process and avoid hardcoded deployment variables and settings.

    1. What is Helm?
        - Helm is a package manager for Kubernetes that combines all your application's resources and deployment information into a single deployment package.

        - You can think of Helm similarly to the Windows Package Manager on Windows, the Advanced Package Tool (apt) on Linux, or Homebrew on macOS. 
            + You specify the name of the application you want to install, update, or remove, and Helm takes care of the process.

        - With Helm, you aren't limited to installing a single app at a time. 
            + Helm allows you to create templated, human-readable YAML script files to manage your application's deployment. 
            + These template files allow you to specify all required dependencies, configuration mapping, and secrets used to manage the deploy of an application successfully.

        - Helm uses four components to manage application deployments on a Kubernetes cluster:
            + 1. Helm client
            + 2. Helm charts
            + 3. Helm releases
            + 4. Helm repositories

    2. What is the Helm client?
        - The Helm client is **a client installed binary responsible for creating and submitting the manifest files required to deploy a Kubernetes application**. 
            + The client is responsible for the interaction between the user and the Kubernetes cluster.

        - The Helm client is available for all major operating systems and is installed on your client PC. 
            + In Azure, the Helm client is preinstalled in the Cloud Shell and supports all security, identity, and authorization features of Kubernetes.

        - NOTICE: **helm version** command

    3. What is a Helm chart?
        - A Helm chart is **a templated deployment package that describes a related set of Kubernetes resources**. 
            + It contains all the information required to build and deploy the manifest files for an application to run on a Kubernetes cluster.

        - A Helm chart consists of several files and folders to describe the chart.
            + Some of the components are required and some are optional.
            + What you choose to include is based on the apps configuration requirements.

        - The following list describes the file and folder components of a Helm chart with the required items in bold:
            + 1. **Chart.yaml**: A YAML file containing the information about the chart.
            + 2. **values.yaml**: The default configuration values for the chart.
            + 3. **templates/**: A folder that contains the deployment templates for the chart.
            + 4. *LICENSE*: A plain text file that contains the license for the chart.
            + 5. *README.md*: A markdown file that contains instructions on how to use the chart.
            + 6. *values.schema.json*: A schema file for applying structure on the values.yaml file.
            + 7. *charts/*: A folder that contains all the subcharts to the main chart.
            + 8. *crds/*: Custom Resource Definitions.
            + 9. *templates/Notes.txt*: A text file that contains template usage notes.

    4. What is a Helm release?
        - A Helm release is **the application or group of applications deployed using a chart**. 
            + Each time you install a chart, a new instance of an application is created on the cluster.
            + Each instance has a release name that allows you to interact with the specific application instance.

        - For example, let's say you installed two Nginx instances onto your Kubernetes cluster using a chart. 
            + Later, you decide to upgrade the first Nginx instance, but not the second. 
            + Since the two releases are different, you can upgrade the first release without impacting the second.

    5. What is a Helm repository?
        - A Helm repository is **a dedicated HTTP server that stores information on Helm charts**.
            + The server hosts a file that describes charts and where to download each chart.

        - The Helm project hosts many public charts, and many repositories exist from which you can reuse charts. 
            + Helm repositories simplify the discoverability and reusability of Helm packages.

    6. Benefits of using Helm
        - Helm introduces a number of benefits that simplify application deployment and improves productivity in the development and deployment lifecycle of cloud-native applications. 
        - With Helm, you have application releases that are:
            + 1. Repeatable,
            + 2. Reliable,
            + 3. Manageable in multiple and complex environments, and
            + 4. Reusable across different development teams.

        - A Helm chart standardizes the deployment of an application using packaged template logic that's parameterized by set input values.
            + This template-driven package design provides an environment-agnostic approach to deploying and sharing cloud-native applications.

2. Exercise - Set up the environment
    1. Set up the environment
        1. Clone the sample application
            1. Set the subscription: **az account set** command
                ```Azure CLI
                az account set --subscription <subscription-name>
                ```
            2. Clone the sample application
                ```
                git clone https://github.com/Azure-Samples/aks-store-demo.git

                cd aks-store-demo
                ```

        2. Create Azure resources
            1. Create a resource group using the **az group create** command
                ```
                az group create --name <resource-group-name> --location <location>
                ```

            2. Create an Azure container registry using the **az acr create** command and provide your own unique registry name. 
                ```
                az acr create --resource-group <resource-group-name> --name <acr-name> --sku Basic
                ```
                - The registry name must be unique within Azure and contain 5-50 alphanumeric characters.

            3. Create an AKS cluster using the **az aks create** command and attach the **ACR** to the AKS cluster using the **--attach-acr** parameter.
                ```
                az aks create --resource-group <resource-group-name> --name <aks-cluster-name> --node-count 2 --attach-acr <acr-name> --generate-ssh-keys
                ```

            4. Connect to the AKS cluster using the **az aks get-credentials** command
                ```
                az aks get-credentials --resource-group <resource-group-name> --name <aks-cluster-name>
                ```

            5. Verify the connection to the AKS cluster using the **kubectl get nodes** command
                ```
                kubectl get nodes
                ```

3. Create and install a Helm chart
    - Helm charts make it simple to deploy applications to any Kubernetes cluster.
        + You use Helm to template your application's deployment information as a Helm chart, which you then use to deploy your application.

    - Let's say your development team already deployed your company's pet store website to your AKS cluster.
    - The team creates three files to deploy the website:
        + 1. A **deployment manifest** that describes how to install and run the application on the cluster,
        + 2. A **service manifest** that describes how to expose the website on the cluster, and
        + 3. An **ingress manifest** that describes how the traffic from outside the cluster routed to the web app.

    - The team deploys these files to each of the three environments as part of the software development lifecycle.
        + Each of the three files is updated with variables and values that are specific to the environment. 
        + Since each file is hardcoded, the maintenance of these files is error-prone.

    1. How does Helm process a chart?
        - The Helm client implements a Go language-based template engine that parses all available files in a chart's folders. 
            + The template engine creates Kubernetes manifest files by combining the templates in the chart's **templates/** folder with the values from the **Chart.yaml** and **values.yaml** files.

        - Once the manifest files are available, the client can install, upgrade, and delete the application defined in the generated manifest files.

    2. How to define a **Chart.yaml** file
        - The Chart.yaml is one of the required files in a Helm chart definition and provides information about the chart. 
        - The contents of the file consists of three required fields and various optional fields.
            + 1. **apiVersion**: The chart API version to use. 
                - You set the version to **v2** for charts that use Helm 3.
            + 2. **name**: The name of the chart.
            + 3. **version**: The version number of the chart, which uses semantic versioning 2.0.0 and follows the **MAJOR.MINOR.PATCH** version number notation.

        - The following example shows the contents of a basic Chart.yaml file:
            ```yml
            apiVersion: v2
            name: webapp
            description: A Helm chart for Kubernetes

            # A chart can be either an 'application' or a 'library' chart.
            #
            # Application charts are a collection of templates that can be packaged into versioned archives
            # to be deployed.
            #
            # Library charts provide useful utilities or functions for the chart developer. They're included as
            # a dependency of application charts to inject those utilities and functions into the rendering
            # pipeline. Library charts do not define any templates and therefore, cannot be deployed.
            type: application

            # This is the chart version. This version number should be incremented each time you make changes
            # to the chart and its templates, including the app version.
            version: 0.1.0

            # This is the version number of the application being deployed. This version number should be
            # incremented each time you make changes to the application.
            appVersion: 1.0.0
            ```

        - NOTICE the use of the **type** field in the example file. 
            + You can create charts to install either *applications* or *libraries*. 
            + The default chart type is *application* and can be set to *library* to specify the chart will install a library.

        - Many optional fields are available to tailor the chart deployment process. 
            + For example, you can use the **dependencies** field to specify extra requirements for the chart, like a web app that depends on a database.

    3. How to define a chart template
        -  Helm chart template is a file describes different deployment type manifest files. 
            + Chart templates are written in the Go template language and provide template functions to automate the creation of Kubernetes object manifest files.
        
        - Template files are stored in the **templates/** folder of a chart. 
            + The template engine processes these files to create the final object manifest.

        - For example, let's say your development team uses the following deployment manifest file to deploy the pet store front component of the solution:
            ```yml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: store-front
            spec:
              replicas: {{ .Values.replicaCount }}
              selector:
                matchLabels:
                  app: store-front
              template:
                metadata:
                  labels:
                    app: store-front
                spec:
                  nodeSelector:
                    "kubernetes.io/os": linux
                  containers:
                  - name: store-front
                    image: {{ .Values.storeFront.image.repository }}:{{ .Values.storeFront.image.tag }}
                    ports:
                    - containerPort: 8080
                      name: store-front
                    env: 
                    - name: VUE_APP_ORDER_SERVICE_URL
                      value: "http://order-service:3000/"
                    - name: VUE_APP_PRODUCT_SERVICE_URL
                      value: "http://product-service:3002/"
                    resources:
                      requests:
                        cpu: 1m
                        memory: 200Mi
                      limits:
                        cpu: 1000m
                        memory: 512Mi
                    startupProbe:
                      httpGet:
                        path: /health
                        port: 8080
                      failureThreshold: 3
                      initialDelaySeconds: 5
                      periodSeconds: 5
                    readinessProbe:
                      httpGet:
                        path: /health
                        port: 8080
                      failureThreshold: 3
                      initialDelaySeconds: 3
                      periodSeconds: 3
                    livenessProbe:
                      httpGet:
                        path: /health
                        port: 8080
                      failureThreshold: 5
                      initialDelaySeconds: 3
                      periodSeconds: 3
            ---
            apiVersion: v1
            kind: Service
            metadata:
              name: store-front
            spec:
              type: {{ .Values.storeFront.serviceType }}
              ports:
              - port: 80
                targetPort: 8080
              selector:
                app: store-front
            ```

        - Notice how the location of the container image is hardcoded using the **{{.Values.<property>}}** syntax. 
            + The syntax allows you to create placeholders for each custom value.

        - The process of creating Helm charts by hand is tedious.
            + An easy way to create a Helm chart is to use the **helm create** command to create a new Helm chart. 
            + You then customize the autogenerated files to match your application's requirements.

    4. How to define a **values.yaml** file
        - You use chart values to customize the configuration of a Helm chart. 
            + Chart values can either be predefined or supplied by the user at the time of deploying the chart.

        - A **predefined value** is a case-sensitive value that's predefined in the context of a Helm chart and can't be changed by a user.
            + For example, you can use **Release.Name** to reference the name of the release 
            + or **Release.IsInstall** to check if the current operation is an installation.

        - You can also use predefined values to extract data from the contents of the **Chart.yaml**.
            + For example, if you want to check the chart's version, you'd reference **Chart.Version**.
            + Keep in mind that you can only reference well-known fields.
        - You can think of **predefined values** as constants to use in the templates you create.

        - The syntax to include value names in a template file involves enclosing the value name in double curly braces, 
            + for example, **{{.Release.Name}}**. 
            + Notice the use of a period in front of the value name.
            + When you use a period in this way, the period functions as a lookup operator and indicates the variable's current scope.

        - For example, the following YAML snippet contains a dictionary defined in a values file:
            ```yml
            object:
              key: value
            ```
            + To access the value in a template, you can use the following syntax:
                ```yml
                {{ .Values.object.key }}
                ```

        - In the example, the development team allows for the following configurable values:
            ```yml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
            name: store-front
            spec:
                replicas: {{ .Values.replicaCount }}
                ...
                    containers:
                    - name: store-front
                        image: {{ .Values.storeFront.image.repository }}:{{ .Values.storeFront.image.tag }}
                        ports:
            ...
            ---
            apiVersion: v1
            kind: Service
            metadata:
                name: store-front
            spec:
                type: {{ .Values.storeFront.serviceType }}
            ...
            ```

            + Here's an example of the **values.yaml** file:
                ```yml
                ...
                replicaCount: 1
                ...
                storeFront:
                    image:
                        repository: "ghcr.io/azure-samples/aks-store-demo/store-front"
                        tag: "latest"
                    serviceType: LoadBalancer
                ...
                ```

            + Once the template engine applies the values, the final result will look like this example:
                ```yml
                apiVersion: apps/v1
                kind: Deployment
                metadata:
                    name: store-front
                spec:
                    replicas: 1
                    ...
                        containers:
                        - name: store-front
                            image: ghcr.io/azure-samples/aks-store-demo/store-front:latest
                            ports:
                ---
                apiVersion: v1
                kind: Service
                metadata:
                    name: store-front
                spec:
                    type: LoadBalancer
                ...

    5. How to use a Helm repository
        - A Helm repository is a dedicated HTTP server that stores information on Helm charts. 
            + You configure Helm repositories with the Helm client for it to install charts from a repository using the **helm repo add** command.

        - For example, you can add the Azure Marketplace Helm repository to your local Helm client by running the following command:
            ```yml
            helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo
            ```

        - Information about charts available on a repository is cached on the client host.
            + You need to periodically update the cache to fetch the repository's latest information using the **helm repo update** command

        - The **helm search repo** command allows you to search for charts on all locally-added Helm repositories. 
            + You can run the **helm search repo** command by itself to return a list of all known Helm charts for each added repository. 
            + The result lists the chart's name, version, and app version deployed by the chart, as shown in the following example output:
                ```
                NAME                               CHART VERSION   APP VERSION   DESCRIPTION
                azure-marketplace/airflow          11.0.8          2.1.4         Apache Airflow is a platform to programmaticall...
                azure-marketplace/apache           8.8.3           2.4.50        Chart for Apache HTTP Server
                azure-marketplace/aspnet-core      1.3.18          3.1.19        ASP.NET Core is an open-source framework create...
                azure-marketplace/bitnami-common   0.0.7           0.0.7         Chart with custom tempaltes used in Bitnami cha...
                azure-marketplace/cassandra        8.0.5           4.0.1         Apache Cassandra is a free and open-source dist...
                ```

        - You can search for a specific chart by adding a search term to the **helm search repo** command. 
            + For example, if you're searching for an ASP.NET based chart, you can use the following command:
                ```Bash
                helm search repo aspnet
                ```
            
            + In this example, the local client has two repositories registered and returns a result from each, 
            + as shown in the following example output:
                ```output
                NAME                            CHART VERSION   APP VERSION   DESCRIPTION                                       
                azure-marketplace/aspnet-core   1.3.18          3.1.19        ASP.NET Core is an open-source framework create...
                bitnami/aspnet-core             1.3.18          3.1.19        ASP.NET Core is an open-source framework create...
                ```

    6. How to test a Helm chart
        - Helm provides an option for you to generate the manifest files that the template engine creates from the chart.
            + This feature allows you to test the chart before a release by combining two extra parameters: **--dry-run** and **debug**.
                - The **--dry-run** parameter ensures that the installation is simulated, 
                - and the -**-debug** parameter enables verbose output.
            
            ```Bash
            helm install --debug --dry-run my-release ./chart-name
            ```
            + The command lists information about the values used and all generated files. 
            + You might have to scroll to view all of the generated output.

    7. How to install a Helm chart
        - You use the **helm install** command to install a chart. 
        - You can install a Helm chart from any of the following locations:
            + 1. Chart folders
            + 2. Packaged **.tgz** tar archive charts
            + 3. Helm repositories

        - However, the required parameters differ depending on the location of the chart. 
            + In all cases, the **install** command requires the name of the chart you want to install and a name for the release the installation creates.

        - You can install a local chart using an unpacked chart folder of files or a packed **.tgz** tar archive. 
            + To install a chart, the **helm** command references the local file system for the chart's location.
            
        - Here's an example of the install command that will deploy a release of an unpacked chart:
            ```Bash
            helm install my-release ./chart-name
            ```
            + **my-release** parameter is the name of the release 
            + **./chart-name** parameter is the name of the unpacked chart package.

        - A packed chart is installed by referencing the packed chart filename. 
            + The following example shows the syntax for the same application now packed as a tar archive:
                ```Bash
                helm install my-release ./chart-name.tgz
                ```

        - When installing a chart from a Helm repository, you use a chart reference as the chart's name. 
            + The chart reference includes two parameters, the repository name and the name of the chart, 
            + as shown in the following example:
                ```Bash
                helm install my-release repository-name/chart-name
                ```
                - **repository-name/chart-name** parameter contains the reference of the repo, **repository-name**, 
                - and the name of the chart, **chart-name**.

4. Exercise - Install a Helm chart
    - Helm charts make it easy to install preconfigured cloud-native apps on a Kubernetes cluster.

    - In this exercise, you'll use Helm to install the pet store application on your Kubernetes cluster.

    1. Deploy a Helm chart
        1. Navigate to the **Azure Cloud Shell** and make sure you're in the **aks-store-demo** directory. 
            - https://shell.azure.com/
            - If not, change to the directory using **cd**.
            ```Bash
            cd aks-store-demo
            ```

        2. Change into the **charts/aks-store-demo** directory using **cd**
            ```Bash
            cd charts
            ```
        
        3. Deploy the pet store front Helm chart using the **helm install** command.
            ```Bash
            helm install aks-store-demo ./aks-store-demo
            ```

            - The command should return a result similar to the following output:
                ```output
                NAME: aks-store-demo
                LAST DEPLOYED: Tue Feb 20 21:05:51 2024
                NAMESPACE: default
                STATUS: deployed
                REVISION: 1
                NOTES:
                1. Get the application URL by running these commands:
                    export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=aks-store-demo,app.kubernetes.io/instance=storedemo2" -o jsonpath="{.items[0].metadata.name}")
                    export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
                    echo "Visit http://127.0.0.1:8080 to use your application"
                    kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
                ```

        4. Helm allows you to query all the installed release on the cluster.
            - List all Helm releases using the **helm list** command
              ```Bash
              helm list
              ```
            
            - The command should return a result similar to the following output:
              ```
              NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
              aks-store-demo  default         1               2024-02-20 21:05:51.557392349 +0000 UTC deployed        aks-store-demo-0.1.0    1.16.0
              ```

        5. Helm allows you to fetch manifest information related to each release. 
            - Fetch manifest information using the **helm get manifest** command
                ```Bash
                helm get manifest aks-store-demo
                ```

            - The command should return a result similar to the following condensed output:
                ```Output
                ---
                # Source: aks-store-demo-chart/templates/order-service.yaml
                apiVersion: v1
                kind: Secret
                metadata:
                    name: order-service-secret
                ...
                ---
                # Source: aks-store-demo-chart/templates/rabbitmq.yaml
                apiVersion: v1
                kind: Secret
                metadata:
                    name: rabbitmq-secret
                ...
                ---
                # Source: aks-store-demo-chart/templates/order-service.yaml
                apiVersion: v1
                kind: ConfigMap
                metadata:
                    name: makeline-service-configmap
                ...
                ```

        6. Validate that the pod is deployed using the **kubectl get pods** command
            ```Bash
            kubectl get pods -o wide -w
            ```

            ```output
            NAME                                         READY   STATUS    RESTARTS   AGE     IP            NODE                                NOMINATED NODE   READINESS GATES
            makeline-service-8747ddb89-j6mvz             1/1     Running   0          6m11s   10.244.2.7    aks-nodepool1-41853373-vmss000001   <none>           <none>
            mongodb-0                                    1/1     Running   0          6m11s   10.244.2.3    aks-nodepool1-41853373-vmss000001   <none>           <none>
            order-service-7854888498-mlsvv               1/1     Running   0          6m11s   10.244.2.8    aks-nodepool1-41853373-vmss000001   <none>           <none>
            product-service-5d7d4f5c47-gr4sc             1/1     Running   0          6m11s   10.244.2.6    aks-nodepool1-41853373-vmss000001   <none>           <none>
            rabbitmq-0                                   1/1     Running   0          6m11s   10.244.2.2    aks-nodepool1-41853373-vmss000001   <none>           <none>
            store-admin-894788d77-k5qjw                  1/1     Running   0          6m11s   10.244.2.10   aks-nodepool1-41853373-vmss000001   <none>           <none>
            store-front-6749d8579c-xdkv8                 1/1     Running   0          6m11s   10.244.2.4    aks-nodepool1-41853373-vmss000001   <none>           <none>
            virtual-customer-76c4bb9b7-dq6lc             1/1     Running   0          6m11s   10.244.2.9    aks-nodepool1-41853373-vmss000001   <none>           <none>
            virtual-worker-56b79f9547-9dkm9              1/1     Running   0          6m11s   10.244.2.5    aks-nodepool1-41853373-vmss000001   <none>           <none>
            ```

    2. Delete a Helm release
        - Delete the Helm release using the **helm delete** command
          ```Bash
          helm delete aks-store-demo

              --> release "aks-store-demo" uninstalled
          ```

    3. Install a Helm chart with set values
        - You can override values for a Helm chart by passing either a value parameter or your own **values.yaml** file. 
        - For now, use the following commands to see how to update a value using the **--set** parameter. 
        - You'll learn how to use a **values.yaml** file in the next unit.
            
        1. Install the Helm chart using the **helm install** command with the **--set** parameter to set the **replicaCount** of the deployment template to five replicas
            ```Bash
            helm install --set replicaCount=5 aks-store-demo ./aks-store-demo
            ```

        2. Validate that five pod replicas were deployed using the **kubectl get pods** command
            ```Bash
            kubectl get pods -o wide -w
            ```

            - The command should return a result similar to the following output:
            ```Output
            NAME                                         READY   STATUS     RESTARTS   AGE   IP            NODE                                NOMINATED NODE   READINESS GATES
            aks-store-demo-c8dfddf78-2v8fv               1/1     Running   0          31s   10.244.1.5    aks-nodepool1-41853373-vmss000000   <none>           <none>
            aks-store-demo-c8dfddf78-8t4rq               1/1     Running   0          31s   10.244.2.16   aks-nodepool1-41853373-vmss000001   <none>           <none>
            aks-store-demo-c8dfddf78-h2p8m               1/1     Running   0          31s   10.244.2.15   aks-nodepool1-41853373-vmss000001   <none>           <none>
            aks-store-demo-c8dfddf78-l8qq2               1/1     Running   0          31s   10.244.0.10   aks-nodepool1-41853373-vmss000002   <none>           <none>
            aks-store-demo-c8dfddf78-xwcpw               1/1     Running   0          31s   10.244.0.9    aks-nodepool1-41853373-vmss000002   <none>           <none>
            ```

        3. Delete the Helm chart using the **helm delete** command
            ```Bash
            helm delete aks-store-demo
            ```

5. Manage a Helm release
    1. How to use functions in a Helm template
        - The Helm template language defines functions that you use to transform values from the **values.yaml** file.
            + The syntax for a function follows the **{{ functionName arg1 arg2 ... }}** structure.
        
        - Let's look at the **quote** function as an example to see this syntax in use.
        - The **quote** function wraps a value in quotations marks to indicate the use of a string.
        - Let's say you define the following **values.yaml** file:
            ```yml
            apiVersion: v2
            name: webapp
            description: A Helm chart for Kubernetes
            ingress:
              enabled: true
            ```
            + You decide you want to use the **ingress.enabled** value as a boolean when determining if an ingress manifest should be generated. 
            + To use the **enabled** value as a boolean, you reference the value using **{{ .Values.ingress.enabled }}**.

            + Later, you decide to display the field as a string in the **templates/Notes.txt** file. 
              - Because YAML type-coercion rules can lead to hard-to-find bugs in templates, you decide to follow guidance and be explicit when including strings in your templates.
              - For example, **enabled: false** doesn't equal **enabled: "false"**.

            + To display the value as a string, you use **{{ quote .Values.ingress.enabled }}** to reference the boolean value as a string.

    2. How to use pipelines in a Helm template
        - You use **pipelines** when more than one function needs to act on a value. 
          + A pipeline allows you to **send** a value, or the result of a function, to another function. 
        
        - For example, you can rewrite the above **quote** function as **{{ .Values.ingress.enabled | quote }}**.
          + NOTICE how the **|** indicates that the value is sent to the quote function.

        - another example: **{{ .Values.ingress.enabled | upper | quote }}**
          + NOTICE how the value is processed by the **upper** function and then the **quote** function.

        - The template language includes over 60 functions that allow you to expose, look up, and transform values and objects in templates.

    3. How to use conditional flow control in a Helm template
        - Conditional flow control allows you to decide the structure or data included in the generated manifest file. 
        
        - For example, you might want to include different values based on the deployment target or control if a manifest file is generated.

        - The if / else block is such a control flow structure and conforms to the following layout:
          ```yml
          {{ if | pipeline | }}
            # Do something
          {{ else if | other pipeline | }}
            # Do something else
          {{ else }}
            # Default case
          {{ end }}
          ```

        - Let's say you decide that the ingress manifest file for a chart is only created in specific cases.
        - The following example shows how to accomplish that using an **if** statement:
          ```yml
          {{ if .Values.ingress.enabled }}
          apiVersion: extensions/v1
          kind: Ingress
          metadata:
            name: ...
            labels:
              ...
            annotations:
              ...
          spec:
            rules:
              ...
          {{ end }}
          ```
          + When the template engine processes the statement, it removes the content declared inside the **{{ }}** syntax and leaves the remaining whitespace. 
          + This syntax causes the template engine to include a newline for the **if** statement line.
          + If you leave the preceding file's contents as-is, you'll notice empty lines in your YAML, and the ingress manifest file is generated.

        - YAML gives meaning to whitespace. 
          + That's why **tabs**, **spaces**, and **newline** characters are considered important. 
          + To fix the problem of unwanted whitespace, you can rewrite the file as follows:
            ```yml
            {{- if .Values.ingress.enabled -}}
            apiVersion: extensions/v1
            kind: Ingress
            metadata:
              name: ...
              labels:
                ...
              annotations:
                ...
            spec:
              rules:
                ...
            {{- end }}
            ```
            - Notice the use of the **-** character as part of the start **{{-** and the end **-}}** sequence of the statement.
            - The **-** character instructs the parser to remove whitespace characters.
            - **{{-** removes whitespace at the start of a line and **-}}** at the end of a line, including the newline character.

    4. How to iterate through a collection of values in a Helm template
        - YAML allows you to define collections of items and use individual items as values in your templates. 
        
        - Accessing items in a collection is possible using an indexer.
        - However, the Helm template language supports the iteration of a collection of values using the **range** operator.
        - Let's say you define a list of values in your **values.yaml** file to indicate additional ingress hosts.

        - Here's an example of the values:
          ```yml
          ingress:
          enabled: true
          extraHosts:
            - name: host1.local
              path: /
            - name: host2.local
              path: /
            - name: host3.local
              path: /
          ```

          + You use the **range** operator to allow the template engine to iterate through the **.Values.ingress.extraHosts**
            ```yml
            {{- if .Values.ingress.enabled -}}
            apiVersion: extensions/v1
            kind: Ingress
            metadata:
              ...
            spec:
              rules:
                ...
                {{- range .Values.ingress.extraHosts }}
                - host: {{ .name }}
                  http:
                    paths:
                      - path: {{ .path }}
                        ...
                {{- end }}
              ...
            {{- end }}
            ```


    5. How to control the scope of values in a Helm template
        - When you have values defined several layers deep, your syntax can become lengthy and cumbersome when including these values in a template. 
        - The **with** action allows you to limit the scope of variables in a template.

        - Remember that the **.** used in a Helm template references the current scope. 
        - For example, the **.Values** instructs the template engine to find the Values object in the current scope. 
        - Let's say you're using the **values.yaml** file from earlier to create a configuration map manifest file:
          ```yml
          ingress:
          enabled: true
          extraHosts:
            - name: host1.local
              path: /
            - name: host2.local
              path: /
            - name: host3.local
              path: /
          ```

        - Instead of accessing each item's path value using **{{ .Values.ingress.extraHosts.path }}**, you can use the **with** action. 
        - The following code snippet shows an example using the **range** operator to generate a configuration map manifest file:
          ```yml
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: {{ .Release.Name }}-configmap
          data:
            {{- with .Values.ingress.extraHosts }}
            hostname: {{ .name }}
            path: {{ .path }}
            {{ end }}
          ```
          + The **{{- with .Values.ingress.extraHosts }}** limits the scope of values to the **.Values.ingress.extraHosts** array          

        - The with action restricts scope. You can't access other objects from the parent scope.
          + To access parent objects, you need to indicate the root scope by using the **$** character or rewrite your code. 
        - Here's the updated code to show how to include parent objects using the **$** character:
          ```yml
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: {{ .Release.Name }}-configmap
          data:
            {{- with .Values.ingress.extraHosts }}
            hostname: {{ .name }}
            path: {{ .path }}
            release: {{ $.Release.Name}}
            {{ end }}
          ```

    6. How to Helm define chart dependencies
        - A chart allows for the declaration of dependencies to support the main application and forms part of the installed release.

        - You can either create a subchart using the **helm create** command, specifying the new chart's location in the **/charts** folder, or use the **helm dependency** command. 
          + Remember that the **/charts** folder might contain subcharts deployed as part of the main chart's release.

        - The helm dependency command allows you to manage dependencies included from a Helm repository. 
          + The command uses metadata defined in the dependencies section of your chart's values file. 
          + You specify the name, version number, and the repository from where to install the subchart.

        - Here's an extract of a values.yaml file that has a MongoDB chart listed as a dependency:
          ```yml
          apiVersion: v2
          name: my-app
          description: A Helm chart for Kubernetes
          ...
          dependencies:
            - name: mongodb
              version: 10.27.2
              repository: https://marketplace.azurecr.io/helm/v1/repo
          ```

        - Once the dependency metadata is defined, you run the **helm dependency build** command to fetch the tar packaged chart. The chart build command downloads the chart into the **charts/** folder.
          ```yml
          helm dependency build ./app-chart
          ```

        - Subcharts are managed separately from the main chart and might need updates as new releases become available. 
          + The command to update subcharts is helm dependency update. 
          + This command fetches new versions of the subchart while deleting outdated packages.
            ```yml
            helm dependency update ./app-chart
            ```

        - Keep in mind that a chart dependency isn't limited to other applications. 
          + You may decide to reuse template logic across your charts and create a dependency specifically to manage this logic as a chart dependency. 
          + You'll get an example of this strategy in the next exercise.

    7. How to upgrade a Helm release
        - Helm allows upgrading existing releases as a delta of all the changes that apply to the chart and its dependencies.

        - For example, let's say the development team of the example **webapp** in this unit makes code changes that impact only the website's functionality. 
          + The team makes the following updates to the **Chart.yaml** file to reflect the new version of the application:
            - 1. Updates the web app's container image and tags the image as **webapp: linux-v2** when pushing the image to the container registry.
            - 2. Updates the **dockerTag** value to **linux-v2** and the chart version value to **0.2.0** in the chart's values file.

        - Here's an example of the updated **values.yaml** file:
          ```yml
          apiVersion: v2
          name: my-app
          description: A Helm chart for Kubernetes

          type: application

          version: 0.2.0
          appVersion: 1.0.0

          registry: "my-acr-registry.azurecr.io"
          dockerTag: "linux-v2"
          pullPolicy: "Always"
          ```

        - Instead of uninstalling a current release, you use the **helm upgrade** command to upgrade the existing Helm release
          ```Bash
          helm upgrade my-app ./app-chart
          ```

        - Remember that Helm generates a delta of the changes made to the Helm chart when you upgrade a release.
          + As such, a Helm upgrade only upgrades the components identified in the delta. 
          + In the example, only the website is redeployed.

        - Once the upgrade completes, you can review the deployment history of the release using the **helm history** command with the release name
          ```Bash
          helm history my-app
          ```

        - Here's an example of the same history command run following a new version install of the web app:
          ```Output
          REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
          1               Mon Oct 11 17:25:33 2021        superseded      aspnet-core-1.3.18      3.1.19          Install complete
          2               Mon Oct 11 17:35:13 2021        deployed        aspnet-core-1.3.18      3.1.19          Upgrade complete
          ```
          + NOTICE the **revision** field in the result. 
            - Helm tracks release information of all releases done for a Helm chart

    8. How to roll back a Helm release
        - Helm allows the rollback of an existing Helm release to a previously installed release. 
          + Recall from earlier that Helm tracks release information of all releases of a Helm chart.

        - You use the **helm rollback** command to roll back to a specific Helm release revision. 
          + This command uses two parameters:
            - The first parameter identifies the name of the release, 
            - and the second identifies the release **revision** number.

          ```Bash
          helm rollback my-app 2
          ```

        - For example, let's say the development team of the example **webapp** in this unit discovers a bug in the drone-tracking web application and needs to roll back to a previous release. 
          + Instead of uninstalling the current release and install a previous version, they roll back to the working release.
          ```Bash
          helm rollback my-app 1
          ```
        
        - Once a rollback completes, you can review the deployment history using the **helm history** command
          ```
          REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
          1               Mon Oct 11 17:25:33 2021        superseded      aspnet-core-1.3.18      3.1.19          Install complete
          2               Mon Oct 11 17:35:13 2021        superseded      aspnet-core-1.3.18      3.1.19          Rolled back to 1
          3               Mon Oct 11 17:38:13 2021        deployed        aspnet-core-1.3.18      3.1.19          Upgrade complete
          ```

6. Summary
    - Manually managing many YAML files introduces unnecessary risk when teams want to target efficient deployment, operation, and maintenance of Kubernetes application releases. 
        + DevOps teams can use Helm to standardize, simplify, and implement reusable deployment packages.

    - In this module, you learned how to:
        + Describe the benefits of using Helm as a Kubernetes package manager
        + Create a Helm chart for a cloud-native application
        + Manage a cloud-native application release using Helm

7. Clean up resources
    - Delete 2 resource groups: cluster resource group (the name is prefixed with MC_) and application resource group

8. Learn more
    - Helm documentation: https://helm.sh/docs/helm/helm/
    - Go template language: https://godoc.org/text/template
    - Azure Kubernetes Service (AKS) documentation: https://learn.microsoft.com/en-us/azure/aks/

### Deploy and manage a stateful application by using Azure Cosmos DB and Azure Kubernetes Service
- https://learn.microsoft.com/en-us/training/modules/aks-manage-application-state/

1. Introduction
    1. Example scenario
        - Imagine you work for a freight company that uses ships to transport goods across the world.
          + The operations department uses a small system that tracks where all the company's ships are docked.
          + Due to staff increases, your company has decided to move this system to Kubernetes.

        - The system's application uses Azure Cosmos DB as a database, and it's built through a separated back end. 
          + You've been tasked with determining how to manage your database access in this distributed environment 
            - and how to deploy a new database to support this critical application.

2. Understand state management in Kubernetes
    1. State
        - The state of the application is everything that's stored in memory by the time the application is running.
          + The state can involve various things, but we mostly focus on the user data.

        - The in-memory state is the information that the application doesn't need to look for anywhere else. 
          + The disk state contains the information that the application doesn't have at hand, so it needs to retrieve that from another data source.

    2. Types of states
        - There are two types of application states. 
            + The first type is the **ephemeral state**, which isn't persistent and vanishes as soon as the application is closed.
                - Containers have an ephemeral state. 
                    + All of the data stored within them is instantly lost when the container is deleted.
                - Some applications can work with that alone, because they can regenerate the state from other sources and don't need the state to be stored locally. 
                    + Those applications are called **stateless applications**.

            + All the remaining state that isn't ephemeral is called **persistent state**.
                - Persistent state continues to exist after the lifecycle of a container. 
                - Most container technologies that we use have the concept of **volume**, an in-disk location where the state exists.
                - Even if you remove the container and turn it back on, the state remains stored in a safe location and can be used again.
                - Applications that rely on an external state to be retrieved are called **stateful applications**.
        
    3. States and Kubernetes
        - Kubernetes can handle both stateless and stateful applications. 
            + Stateless apps are easier because we can focus only on the application itself and not on its state (since it doesn't exist).

        - For most stateless applications, a simple deployment workload with a pod would be enough for you to have a fully functioning system and to make the most of your cluster.

        - Dealing with stateful applications is the opposite. 
            + In these cases, you need to consider the application and its state, where the state is stored, and how you can store the state securely and reliably.

        - This is why Kubernetes also has the concept of **PersistentVolumes** (PVs) and **PersistentVolumeClaims** (PVCs).

        - **PersistentVolumes** are disks that are allocated in nodes to store states from a pod's container. 
            + Because Kubernetes is best for distributed apps, all created volumes lie in a pool of **available volumes**. 
            + Containers then claim that space for themselves. 
            + You can use **PersistentVolumeClaims** to bind a **PersistentVolume** with a pod and use its space to store the needed data.

        - All database providers are stateful applications. 
            + If you're deploying a database provider in your cluster, you need a PV and a PVC to store the database data in a safe spot and allow the provider to retrieve that data even if its containers were deleted.

    4. Best practices for state handling
        - State is present in most applications. However, a best practice for handling state is to not deal with it at all.

        - You design any efficient application with the goal of making it highly available and scalable. 
            + State goes in the opposite direction. 
            + Despite the options provided by storage providers and the ease of deployment and use, state doesn't scale easily. 
                - It's not highly available either.

        1. Highly available state
            - To be highly available, an application must be online at all times. This is done through zone and region replication.
            
            - Kubernetes is zone aware in most of its workloads. 
                + That means you can have several instances of an application that are deployed in different zones. 
                + However, disks aren't zone aware.

            - When you deploy a new **PersistentVolume** object on Kubernetes, it's bound to a disk on a node. 
                + That disk is also bound to a particular zone in a particular region. 
                + Using zone or region replication with PVs is complex and requires a lot of maintenance, both to replicate and to synchronize data.

        2. Highly scalable state
            - To be highly scalable, an application should grow its throughput together with the number of users who are connected to it. 
                + This is complicated in state management because any external state is essentially a disk, and a disk has a limited input and output rate. 
                + Throughput management helps solve this problem.

            - Database solutions came up with the idea of **ReplicaSets**, which replicate the whole database into multiple instances.
                + The replication increases the number of disks and the I/O for the state.

            - On every database change, the state needs to be synchronized so that all disks contain the same data.
                + This synchronization is also complex.

        3. Externalizing the state
            - Azure has platform as a service (PaaS) solutions, like Azure Cosmos DB, that are highly available and scalable and solve most of the state management problems for you.

            - Storing state externally and removing the need for maintenance can help you to focus on the application and reduce the overhead of dealing with data integrity in your infrastructure.

3. Host a new database using Azure Cosmos DB
    1. Create a resource group
        ```Azure CLI
        az group create --name rg-ship-manager --location eastus
        ```

    2. Create the state
        - As we described earlier, it's possible but not recommended to handle state in Kubernetes.
            + Managing a highly available application state can become too difficult when you need to manage the state yourself.

        - To solve that problem, we'll externalize the state to an application that specializes in dealing with external state: Azure Cosmos DB.

        1. Create Bash variables to store the Azure Cosmos DB account name and the resource group name for use throughout the rest of the module
            ```Bash
            export RESOURCE_GROUP=rg-ship-manager
            export COSMOSDB_ACCOUNT_NAME=contoso-ship-manager-$RANDOM
            ```

        2. Create a new Azure Cosmos DB account using the **az cosmosdb create** command
            ```Azure CLI
            az cosmosdb create --name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --kind MongoDB
            ```

        3. Create a new database using the **az cosmosdb mongodb database create** command. 
            - In this example, the database is named **contoso-ship-manager**
            
            ```Azure CLI
            az cosmosdb mongodb database create --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --name contoso-ship-manager
            ```
        
        - NOTICE: Now that you've created an external state to store all the data from the ship manager application, 
            + let's create the AKS resource to store the application itself.

        4. Verify the database was successfully created using the **az cosmosdb mongodb database list** command
            ```Azure CLI
            az cosmosdb mongodb database list --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP -o table

              --> Name                  ResourceGroup
                  contoso-ship-manager  rg-ship-manager
            ```

        - Now that you've created an external state to store all the data from the ship manager application,
          + let's create the AKS resource to store the application itself.

    3. Create the AKS cluster
        1. Create a Bash variable to store the cluster name for use throughout the rest of the module
            ```Bash
            AKS_CLUSTER_NAME=ship-manager-cluster
            ```

        2. Create an AKS cluster using the **az aks create** command
            ```Azure CLI
            az aks create --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --node-count 3 --generate-ssh-keys --node-vm-size Standard_B2s --enable-addons http_application_routing
            ```

            - NOTE: All Azure services set default limits and quotas for resources and features, including usage restrictions for certain virtual machine (VM) SKUs. 
                + If you encounter an error suggesting your desired VM SKU is not available in the region you've selected, you most likely need to increase this quota.

        3. Download the kubectl configuration using the **az aks get-credentials** command
            ```Azure CLI
            az aks get-credentials --name $AKS_CLUSTER_NAME --resource-group $RESOURCE_GROUP

                --> A different object named ship-manager-cluster already exists in your kubeconfig file.
                    Overwrite? (y/n): y
            ```

        4. Test the configuration using the **kubectl get nodes** command
            ```Azure CLI
            kubectl get nodes

                -->
                NAME                                STATUS   ROLES   AGE     VERSION
                aks-nodepool1-12345678-vmss000000   Ready    agent   3m19s   v1.27.7
                aks-nodepool1-12345678-vmss000001   Ready    agent   3m25s   v1.27.7
                aks-nodepool1-12345678-vmss000002   Ready    agent   3m20s   v1.27.7
            ```

    4. Deploy the application
        - To create the application, you need to create the YAML files to deploy to Kubernetes.

        1. Deploy the back-end API
            1. Get your Azure Cosmos DB database connection string using the **az cosmosdb keys list** command
                ```Azure CLI
                az cosmosdb keys list --type connection-strings -g $RESOURCE_GROUP -n $COSMOSDB_ACCOUNT_NAME --query "connectionStrings[0].connectionString" -o tsv
                
                    --> mongodb://contoso-ship-manager-12345678.documents.azure.com:10255/?ssl=true&replicaSet=globaldb
                ```

            2. Create a new file named **backend-deploy.yml** and paste in the following deployment specification
                ```yml
                apiVersion: apps/v1
                kind: Deployment
                metadata:
                  name: ship-manager-backend
                spec:
                  replicas: 1
                  selector:
                    matchLabels:
                      app: ship-manager-backend
                  template:
                    metadata:
                      labels:
                        app: ship-manager-backend
                    spec:
                      containers:
                        - image: mcr.microsoft.com/mslearn/samples/contoso-ship-manager:backend
                          name: ship-manager-backend
                          resources:
                            requests:
                              cpu: 100m
                              memory: 128Mi
                            limits:
                              cpu: 250m
                              memory: 256Mi
                          ports:
                            - containerPort: 3000
                              name: http
                          env:
                            - name: DATABASE_MONGODB_URI
                              value: "{your database connection string}"
                            - name: DATABASE_MONGODB_DBNAME
                              value: contoso-ship-manager
                ```
            
            3. Replace the **{your database connection string}** placeholder with the database connection string
                - NOTE: Don't forget to add quotes `"` to the environment variables, as the connection string sometimes presents invalid YAML characters.
                  + You might consider using secrets as a **secure** way to store and retrieve connection string in AKS.
                    - secure: https://learn.microsoft.com/en-us/training/modules/aks-secrets-configure-app/

            4. Apply the back-end API deployment using the **kubectl apply** command
                ```
                kubectl apply -f backend-deploy.yml

                  --> deployment.apps/ship-manager-backend created
                ```

            - To make this application available to everyone, you need to create a service and an ingress to take care of the traffic.

              1. Get your cluster API server address using the **az aks show** command
                  ```
                  az aks show -g $RESOURCE_GROUP -n $AKS_CLUSTER_NAME -o tsv --query fqdn

                    -> host-name: ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io
                  ```

              2. Create a new file named **backend-network.yml** and paste in the following networking specification
                  ```yml
                  apiVersion: v1
                  kind: Service
                  metadata:
                    name: ship-manager-backend
                  spec:
                    type: ClusterIP
                    ports:
                    - port: 80
                      targetPort: 3000
                    selector:
                      app: ship-manager-backend
                  ---
                  apiVersion: networking.k8s.io/v1
                  kind: Ingress
                  metadata:
                    name: ship-manager-backend
                  spec:
                    ingressClassName: webapprouting.kubernetes.azure.com
                    rules:
                    - host: <host-name>
                      http:
                        paths:
                        - backend:
                            service:
                              name: ship-manager-backend
                              port:
                                number: 80
                          path: /
                          pathType: Prefix
                  ```
                  - Replace the **<host-name>** placeholder with the connection string you retrieved in the previous step

              3. Apply the back-end networking deployment using the **kubectl apply** command
                  ```
                  kubectl apply -f backend-network.yml

                    --> service/ship-manager-backend created
                        ingress.networking.k8s.io/ship-manager-backend created
                  ```

                  - You can access the API through the host name that you pasted in your ingress resource.
                      + The Azure DNS zone resource can take up to five minutes to complete the DNS detection. 
                      + If you can't access the API right away, wait a few minutes and try again.

              4. Check the ingress status by querying Kubernetes for the available ingresses using the **kubectl get ingress** command.
                  ```Azure CLI
                  kubectl get ingress
                  ```

                  - Once the **ADDRESS** field in the output is filled, it means the ingress has been deployed and it's ready to be accessed,
                    + as shown in the following example output:
                      ```
                      NAME                   CLASS                                HOSTS                                                               ADDRESS        PORTS   AGE
                      ship-manager-backend   webapprouting.kubernetes.azure.com   ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io     xx.xx.xx.xx    80      2m40s
                      ```

        2. Deploy the front-end interface
            1. Create a new file named **frontend-deploy.yml** and paste in the following deployment specification
                ```yml
                apiVersion: apps/v1
                kind: Deployment
                metadata:
                  name: ship-manager-frontend
                spec:
                  replicas: 1
                  selector:
                    matchLabels:
                      app: ship-manager-frontend
                  template:
                    metadata:
                      labels:
                        app: ship-manager-frontend
                    spec:
                      containers:
                        - image: mcr.microsoft.com/mslearn/samples/contoso-ship-manager:frontend
                          name: ship-manager-frontend
                          imagePullPolicy: Always
                          resources:
                            requests:
                              cpu: 100m
                              memory: 128Mi
                            limits:
                              cpu: 250m
                              memory: 256Mi
                          ports:
                            - containerPort: 80
                          volumeMounts:
                            - name: config
                              mountPath: /usr/src/app/dist/config.js
                              subPath: config.js
                      volumes:
                        - name: config
                          configMap:
                            name: frontend-config
                ---
                apiVersion: v1
                kind: ConfigMap
                metadata:
                  name: frontend-config
                data:
                  config.js: |
                    const config = (() => {
                      return {
                        'VUE_APP_BACKEND_BASE_URL': 'http://{YOUR_BACKEND_URL}',
                      }
                    })()
                ```

            2. Replace the **{YOUR_BACKEND_URL}** placeholder with the host name URL of the back-end API
            3. Apply the front-end deployment using the **kubectl apply** command
                ```Azure CLI
                kubectl apply -f frontend-deploy.yml

                  --> deployment.apps/ship-manager-frontend created
                      configmap/frontend-config created
                ```

            - Next, you can create the networking resources that this application needs to be open to the web
              1. Create a new file named **frontend-network.yml** and paste in the following networking specification
                  ```yml
                  apiVersion: v1
                  kind: Service
                  metadata:
                    name: ship-manager-frontend
                  spec:
                    type: ClusterIP
                    ports:
                    - port: 80
                      targetPort: 80
                    selector:
                      app: ship-manager-frontend
                  ---
                  apiVersion: networking.k8s.io/v1
                  kind: Ingress
                  metadata:
                    name: ship-manager-frontend
                  spec:
                    ingressClassName: webapprouting.kubernetes.azure.com
                    rules:
                    - host: <host-name>
                      http:
                        paths:
                        - backend:
                            service:
                              name: ship-manager-frontend
                              port:
                                number: 80
                          path: /
                          pathType: Prefix
                  ```

              2. Replace the **<host-name>** placeholder with the connection string you retrieved in the previous section
              3. Apply the front-end networking deployment using the kubectl apply command
                  ```Azure CLI
                  kubectl apply -f frontend-network.yml

                    --> service/ship-manager-frontend created
                        ingress.networking.k8s.io/ship-manager-frontend created
                  ```
                  - You can access the API through the host name that you pasted in your ingress resource. 
                    + The Azure DNS zone resource can take up to five minutes to complete the DNS detection. 
                    + If you can't access the API right away, wait a few minutes and try again.

              4. Check the ingress status by querying Kubernetes for the available ingresses using the **kubectl get ingress** command.
                  ```
                  kubectl get ingress

                    --> NAME                   CLASS                                HOSTS                                                               ADDRESS        PORTS   AGE
                        ship-manager-backend   webapprouting.kubernetes.azure.com   ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io     xx.xx.xx.xx    80      2m40s
                        ship-manager-frontend  webapprouting.kubernetes.azure.com   ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io     xx.xx.xx.xx    80      100s
                  ```
                  - Once the **ADDRESS** field in the output is filled, it means the ingress has been deployed and it's ready to be accessed.

4. Summary
    - By creating a new instance of Azure Cosmos DB, you delegated the management of the database to Azure.
    - The application can grow across many regions in the world without any added complexity.
    - Now, your cluster has a better handling of application states. 
    - Your cluster is also scalable to the point where you can handle multiple users without needing to configure the database.

5. Clean up resources
    1. Delete resource group: **rg-ship-manager** and **MC_rg-ship-manager_ship-manager-cluster_eastus**
    2. Remove the deleted cluster's context using the **kubectl config delete-context** command. 
        - Remember to replace the name of the cluster with your cluster's name
        ```
        kubectl config delete-context ship-manager-cluster

          --> deleted context ship-manager-cluster from /home/user/.kube/config
        ```

6. Learn more
    - To learn more about Azure Kubernetes Service
      + 1. Introduction to AKS: https://learn.microsoft.com/en-us/training/modules/intro-to-azure-kubernetes-service/
      + 2. AKS documentation: https://learn.microsoft.com/en-us/azure/aks/
      + 2. AKS production baseline: 
          - https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks
      + 2. Deploy an AKS cluster: https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster
      + 2. Storage concepts with AKS: https://learn.microsoft.com/en-us/azure/aks/concepts-storage

### Manage application configuration and secrets in Azure Kubernetes Service (AKS)
- https://learn.microsoft.com/en-us/training/modules/aks-secrets-configure-app/
- https://github.com/Azure-Samples/aks-contoso-ships-sample

1. Introduction
    - Imagine that you work for a freight company that uses ships to transport goods across the world.
    - The operations department uses a small system that tracks where all the company's ships are docked.
    - Due to staff increases, your company decided to move this system to Azure Kubernetes Service (AKS).
    - However, the security team noted some flaws in the app configuration: some configurations were hardcoded in the app, and some sensitive values like connection strings were left as plain text.
    - These flaws require changes before the application can be deployed for production use.

2. Understand Kubernetes Secrets
    - One of the biggest considerations when working with distributed applications is how to manage sensitive information, like passwords, connections, and similar data. 
      + Kubernetes allows you to secure this data with a resource called a **Secret**.

    1. Understand Secrets
        - In Kubernetes, Secrets allow you to store sensitive information in a safer way than plain text format in pods and deployments.
          + Secrets are designed to store passwords and other sensitive data.

        - Kubernetes Secrets encode their data in a base64 format. 
          + Although base64 isn't an encryption algorithm, Kubernetes can see that the information is encoded and can hide this information from command outputs such as **kubectl describe**. 
          + This process doesn't happen with plain text configuration.
          + Secrets are always scoped to a single namespace to avoid added exposure of sensitive data to other workloads in the cluster.

        1. Types of Secrets
            - There are different types of Secrets.
              + The most common and default type is **Opaque**, which holds user-defined, arbitrary data.

            - The other common types include:
              + 1. **kubernetes.io/service-account-token**: Defines a Service Account Token, and is automatically created when a new Service Account is created.
              + 2. **kubernetes.io/basic-auth**: Credentials for basic authentication.
              + 3. **kubernetes.io/tls**: TLS client or server data, used to serve HTTPS connections from within an Ingress resource, for example.

            - For more information, see **Kubernetes Secrets documentation**:
              + https://kubernetes.io/docs/concepts/configuration/secret/#secret-types
    
    2. Create and use a Secret
        - According to the official Kubernetes Secrets documentation, you can use a Secret in three different ways:
          + 1. Mounted as files in a volume on containers inside a Pod or Deployment.
          + 2. Referenced as an environment variable in the Pod or Deployment specification.
          + 3. Used by the Kubelet when pulling images from private registries via the **imagePullSecret** key in the Pod specification.

        - You can create Secrets like any other Kubernetes resource, using either a YAML manifest file or a kubectl command. 
        - The Secret specification is as follows:
          ```yml
          apiVersion: v1
          kind: Secret
          metadata:
            name: secret-name
            namespace: secret-namespace
          type: Opaque
          data:
            key_name: "key value in base64 format"
          ```

        - For a Secret with this specification, you need to encode the values before you create the Secret. 
        - If you want to create a Secret with the plain text value and let Kubernetes encode it automatically, 
          + you use **stringData** instead of **data**:
            ```yml
            apiVersion: v1
            kind: Secret
            metadata:
              name: secret-name
              namespace: secret-namespace
            type: Opaque
            stringData:
              key_name: "key value in plain format"
            ```
            + The application receives the **decoded** Secret string as the value passed to it instead of the encoded one,            

        1. Secret updates
            - All Secrets that are **mounted as volumes** inside a pod are automatically updated once their value changes. 
              + This change might not occur immediately because of the **Kubelet configuration**, 
                - but it happens automatically so there's no need to restart the Pod.
                - Kubelet configuration: https://kubernetes.io/docs/concepts/configuration/configmap/#mounted-configmaps-are-updated-automatically

            - In cases where Secrets are **bound to environment variables** they aren't automatically updated, 
              + making it necessary to restart the Pod for the changes to take effect.

3. Exercise - Securely store variables in secrets
    1. Create a resource group and AKS cluster
        1. Create environment variables for your resource group, cluster, DNS zone, and location. 
          + Make sure you update the LOCATION variable with the region closest to you, for example, **eastus**.
            ```Azure CLI
            export RESOURCE_GROUP=rg-ship-manager
            export CLUSTER_NAME=ship-manager-cluster
            export ZONE_NAME=ship-$RANDOM.com
            export LOCATION={location}
            ```

        2. Run the following command to view the values of your environment variables and make a note of them for later use.
            ```
            echo "RESOURCE_GROUP:" $RESOURCE_GROUP
            echo "CLUSTER_NAME:"$CLUSTER_NAME
            echo "ZONE_NAME:" $ZONE_NAME
            echo "LOCATION:"$LOCATION
            ```

        3. Create a resource group using the **az group create** command
            ```
            az group create --location $LOCATION --name $RESOURCE_GROUP
            ```

        4. Create an AKS cluster using the **az aks create** command
            ```
            az aks create -g $RESOURCE_GROUP -n $CLUSTER_NAME --location $LOCATION --node-count 1 --node-vm-size Standard_B2s --generate-ssh-keys
            ```

        5. Enable the application routing add-on with the following command
            ```
            az aks approuting enable -g $RESOURCE_GROUP -n $CLUSTER_NAME
            ```
            - NOTE: If you see a message asking you to install the **aks-preview** extension, enter **Y** to install it and continue

        6. Create a DNS zone using the **az network dns zone create** command
            ```
            az network dns zone create -g $RESOURCE_GROUP -n $ZONE_NAME
            ```
    
        7. Retrieve the ID of your DNS zone and use it as part of the command to add the zone to your cluster for app routing
            ```Azure CLI
            ZONEID=$(az network dns zone show -g $RESOURCE_GROUP -n $ZONE_NAME --query "id" --output tsv)
            az aks approuting zone add -g $RESOURCE_GROUP -n $CLUSTER_NAME --ids=${ZONEID} --attach-zones
            ```

        8. Get the credentials for your cluster using the az aks get-credentials command
            ```Azure CLI
            az aks get-credentials -n $CLUSTER_NAME -g $RESOURCE_GROUP
            ```

    2. Create a Secret
        1. Deploy a MongoDB database to support the application using the **az cosmosdb create** command
            ```Azure CLI
            export DATABASE_NAME=contoso-ship-manager-$RANDOM && az cosmosdb create -n $DATABASE_NAME -g $RESOURCE_GROUP --kind MongoDB
            ```

        2. Once the database is created, get the connection string using the **az cosmosdb keys list** command and copy the output value
            ```Azure CLI
            az cosmosdb keys list --type connection-strings -g $RESOURCE_GROUP -n $DATABASE_NAME -o tsv --query "connectionStrings[0].connectionString"
            ```

        3. Create a new YAML file named **backend-secret.yaml** and paste in the following code to create the Secret spec.
            - Make sure to replace the placeholder string with the connection string from the previous output.
              ```yml
              apiVersion: v1
              kind: Secret
              metadata:
                name: ship-manager-database
                namespace: default
              type: Opaque
              stringData:
                database_mongodb_uri: "<paste the connection string here>"
              ```

        4. Apply the secret using the **kubectl apply** command
            ```Azure CLI
            kubectl apply -f backend-secret.yaml
            ```

        5. Check the result by querying for the secret using the **kubectl get secret** command
            ```Azure CLI
            kubectl get secret ship-manager-database

              --> NAME                    TYPE     DATA   AGE
                  ship-manager-database   Opaque   1      5s
            ```

    3. Create the application
        1. Create a new YAML file named **backend-application.yaml** and paste in the following code to create the Deployment spec.
            ```yml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: ship-manager-backend
              namespace: default
            spec:
              replicas: 1
              selector:
                matchLabels:
                  app: ship-manager-backend
              template:
                metadata:
                  labels:
                    app: ship-manager-backend
                spec:
                  containers:
                    - image: mcr.microsoft.com/mslearn/samples/contoso-ship-manager:backend
                      name: ship-manager-backend
                      ports:
                        - containerPort: 3000
                          name: http
                      env:
                        - name: DATABASE_MONGODB_URI
                          valueFrom:
                            secretKeyRef:
                              key: database_mongodb_uri
                              name: ship-manager-database
                        - name: DATABASE_MONGODB_DBNAME
                          value: ship_manager
            ```
            - NOTICE that in the env section, we use the **valueFrom** and the **secretKeyRef** keys. 
              + The order of these keys tells the deployment to use the value from the **key** present in the Secret defined in the **name** key.

        2. Add three dashes below the last line in the **backend-application.yaml** file to separate the next section
            ```yml
            # Previous lines from the deployment
            value: ship_manager
            ---
            apiVersion: v1
            kind: Service
            metadata:
              name: ship-manager-backend
              namespace: default
            spec:
              selector:
                app: ship-manager-backend
              ports:
                - name: http
                  port: 80
                  targetPort: 3000
            ---
            ```

        3. Below the three dashes, paste in the following code to create the Ingress spec
            ```yml
            apiVersion: networking.k8s.io/v1
            kind: Ingress
            metadata:
              name: ship-manager-backend
              namespace: default
              annotations:
                spec.ingressClassName: webapprouting.kubernetes.azure.com
            spec:
              rules:
                - host: ship-manager-backend.<paste the ZONE_NAME here>
                  http:
                    paths:
                      - path: /
                        pathType: Prefix
                        backend:
                          service:
                            name: ship-manager-backend
                            port:
                              name: http
            ```

        4. Change the DNS zone in the **host:** to match the name of your DNS zone.
            - Use the value of the ZONE_NAME variable you created earlier.

        5. Apply the changes to your cluster using the kubectl apply command
            ```Azure CLI
            kubectl apply -f backend-application.yaml
            ```

4. Understand Kubernetes ConfigMaps
    - In the application repository, there's a **config file** loaded in the **index.html** file to allow the environment variables to be updated without the need of a full image build.

    - The configuration file doesn't contain sensitive information, it just needs to be loaded along with the container.
      + How can we mount the file in the container without the need of encryption or encoding?

    1. Understand ConfigMaps
        - ConfigMaps are counterparts to Secrets.
          + While Secrets provide a way to store and deliver sensitive data, ConfigMaps are objects that provide a way to store nonsensitive data using the same key-value structure as a Secret.
          + The ConfigMaps object allows you to decouple configurations from container images so the images remain stateless.

        - You create a ConfigMap to store configuration data separately from the application code and load it similarly to how we load Secret objects in the Pod. 
          + You can only reference ConfigMaps by using an environment variable, or by mounting them as a file in a volume inside the container.

        - ConfigMaps have a data size limitation: you can hold up to **1 MiB** of data in a ConfigMap.
          + The size limitation helps you avoid large, complex configuration files by having you break large configurations into smaller chunks.
          + With ConfigMaps, you can mount only the required configuration files in your containers, which allows for more granularity.

        - Like Secrets, ConfigMaps are namespaced.
          + You can only access and mount a ConfigMap by using the containers present in the same namespace that it was created in.

        - ConfigMaps are also widely used by other tools, such as **Helm** and Kubernetes Operators, to store and read states

        1. ConfigMap updates
            - All ConfigMaps that are **mounted as volumes** inside a pod are automatically updated once their value is changed. 
              + This change might not occur immediately because of the **Kubelet configuration**, but it happens automatically so there's no need to restart the Pod.
                - https://kubernetes.io/docs/concepts/configuration/configmap/#mounted-configmaps-are-updated-automatically

            - When a ConfigMap is **bound to environment variables**, it isn't automatically updated. 
              + For these cases, it's necessary to restart the Pod for the changes to take effect.

    2. Create and use ConfigMaps
        - You can create a ConfigMap using the same approach as a Secret: a YAML file. The ConfigMap specification is as follows:
          ```yml
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: configmap-name
            namespace: default
          data:
            key-name: "value as key"
            key.name: |
              multi line
              property, called "file-like" values
          ```

        - You can reference ConfigMaps by one or more keys in the specification of a Pod or Deployment, as shown in the following example:
          ```yml
          apiVersion: v1
          kind: Pod
          metadata:
            name: configmap-as-env
            namespace: default
          spec:
            containers:
              - name: configmap-env
                image: alpine
                command: ["sleep", "3600"]
                env:
                  - name: ENVIRONMENT_VARIABLE_NAME
                    valueFrom:
                      configMapKeyRef:
                        name: configmap-name
                        key: key-name
          ```          

        - You can also mount them as files inside the pod using read-only volumes, as shown in the following example:
          ```yml
          apiVersion: v1
          kind: Pod
          metadata:
            name: configmap-as-env
            namespace: default
          spec:
            containers:
              - name: configmap-env
                image: alpine
                command: ["sleep", "3600"]
                volumeMounts:
                - name: volume-name
                  mountPath: "/path/to/mount"
                  readOnly: true
            volumes:
              - name: volume-name
                configMap:
                  name: configmap-name
                  items:
                  - key: "key-name"
                    path: "path/to/mount/the/key"
          ```

5. Exercise - Enhance the application with configmaps
    - You deployed the application back end, and now you need to deploy the application front end using a ConfigMap.

    1. Create a ConfigMap
        1. Create a new YAML file named **configmap.yaml** and paste in the following code to create the ConfigMap spec
            ```yml
            apiVersion: v1
            kind: ConfigMap
            metadata:
                name: ship-manager-config
                namespace: default
            data:
                config.js: |
                const config = (() => {
                    return {
                    'VUE_APP_BACKEND_BASE_URL': 'http://ship-manager-backend.{your-dns-zone}.aksapp.io',
                    }
                })()
            ```

        2. Replace **{your-dns-zone}** with the value of the ZONE_NAME variable you created earlier

        3. Apply the changes to your cluster using the **kubectl apply** command
            ```Azure CLI
            kubectl apply -f configmap.yaml
            ```

        4. Check the result by querying for the ConfigMap using the **kubectl get configmap** command
            ```Azure CLI
            kubectl get configmap ship-manager-config
            ```

    2. Create the application
        1. Create a new YAML file named **frontend.yaml** and paste in the following code to create the Deployment spec
            ```yml
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: contoso-ship-manager-frontend
              namespace: default
            spec:
              replicas: 1
              selector:
                matchLabels:
                  app: contoso-ship-manager-frontend
              template:
                metadata:
                  labels:
                    app: contoso-ship-manager-frontend
                spec:
                  containers:
                    - image: mcr.microsoft.com/mslearn/samples/contoso-ship-manager:frontend
                      name: contoso-ship-manager-frontend
                      ports:
                        - containerPort: 80
                          name: http
                      volumeMounts:
                        - name: config
                          mountPath: /usr/src/app/dist/config.js
                          subPath: config.js
                  volumes:
                    - name: config
                      configMap:
                        name: ship-manager-config
            ---
            ```

            - Notice how the ConfigMap is mounted in the Deployment object.
              + We don't specify any keys, which means we need to specify a **subPath** key. 
              + The **subpath** is the filename inside the container.

        2. Below the three dashes, paste in the following code to create the Service and Ingress specs
            ```yml
            apiVersion: v1
            kind: Service
            metadata:
              name: contoso-ship-manager-frontend
              namespace: default
            spec:
              selector:
                app: contoso-ship-manager-frontend
              ports:
                - name: http
                  port: 80
                  targetPort: 80
            ---
            apiVersion: networking.k8s.io/v1
            kind: Ingress
            metadata:
              name: contoso-ship-manager-frontend
              namespace: default
              annotations:
                spec.ingressClassName: webapprouting.kubernetes.azure.com
            spec:
              rules:
                - host: contoso-ship-manager.{your-dns-zone}.aksapp.io
                  http:
                    paths:
                      - path: /
                        pathType: Prefix
                        backend:
                          service:
                            name: contoso-ship-manager-frontend
                            port: 
                              name: http
            ```
        
        3. Replace **{your-dns-zone}** in the Ingress with the value of the ZONE_NAME variable you created earlier

        4. Deploy the application using the **kubectl apply** command
            ```Azure CLI
            kubectl apply -f frontend.yaml
            ```

        5. Check the result by querying the Kubernetes API using the **kubectl get deployment** command
            ```Azure CLI
            kubectl get deployment contoso-ship-manager-frontend

              --> NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
                  contoso-ship-manager-frontend  1/1     1            1           18s
            ```

6. Summary
    - By using secrets to keep the connection string safe, you're able to better understand and secure the managed application state, and still deploy your application without any problems. 
    - Now, your cluster is better able to handle sensitive values and configurations using ConfigMaps to inject configurations without the need to reboot your application.

7. Clean up resources
    1. Delete resource group: rg-ship-manager and MC_rg-ship-manager_ship-manager-cluster_eastus
    2. Remove the delete cluster's context using the **kubectl config delete-context**
        ```Azure CLI
        kubectl config delete-context ship-manager

          --> deleted context ship-manager from /home/user/.kube/config
        ```

### Optimize compute costs on Azure Kubernetes Service (AKS)
- Optimize costs on AKS by using zero-scaled node pools
- Optimize costs on AKS by using autoscaled spot node pools
- Manage costs with Azure Policy on AKS

1. Configure multiple nodes and enable scale-to-zero by using AKS
    - Azure Kubernetes Service allows you to create different node pools to match specific workloads to the nodes running in each node pool. 
        + The process of matching workloads to nodes lets you plan to compute consumption and optimize cost.

    - Your company's drone-tracking solution is deployed on Azure Kubernetes Service (AKS) as many containerized applications and services. 
        + Your team developed a new predictive-modeling service that processes flight-path information in extreme weather conditions and creates optimal flight routes. 
        + This service requires GPU-based virtual-machine (VM) support and runs only on specific days during the week.

    - You want to configure a cluster node pool dedicated to processing flight-path information. 
        + The process runs for only a couple of hours a day, and you want to use a GPU-based node pool. 
        + However, you want to pay for the nodes only when you use them.

    1. What is a node pool?
        - A node pool describes a group of nodes with the same configuration in an AKS cluster.
            + These nodes contain the underlying VMs that run your applications. 
        
        - You can create two types of node pools on an AKS-managed Kubernetes cluster: 
            + 1. System node pools
            + 2. User node pools

            1. System node pools
                - System node pools host critical system pods that make up your cluster's control plane.
                    + A system node pool allows the use of Linux only as the node OS and runs only Linux-based workloads.
                    + Nodes in a system node pool are reserved for system workloads and normally not used to run custom workloads. 
                    + Every AKS cluster must contain at least one system node pool with at least one node, and you must define the underlying **VM sizes** for nodes.

            2. User node pools
                - User node pools support your workloads, and you can specify Windows or Linux as the node operating system.
                - You can also define the underlying VM sizes for nodes and run specific workloads.
                - For example, 
                    + your drone-tracking solution has a batch-processing service that you deploy to a node pool with a configuration for general-purpose VMs.
                    + The new predictive-modeling service requires higher-capacity, GPU-based VMs. 
                        - You decide to configure a separate node pool and configure it to use GPU-enabled nodes.

    2. Number of nodes in a node pool
        - You can configure up to 100 nodes in a node pool. 
            + However, the **number of nodes** you choose to configure depends on the **number of pods** that run **per node**.

        - For example,
            + in a **system node pool**, it's essential to set the maximum number of pods that run on a single node to 30. 
                - This value guarantees that enough space is available to run the system pods critical to cluster health.
                - When the number of pods exceeds this minimum value, new nodes are required in the pool to schedule extra workloads. 
                - For this reason, a system node pool needs at least one node in the pool. 
                - For production environments, the recommended node count for a system node pool is a minimum of three nodes.

            + User node pools are designed to run custom workloads and don't have the 30-pod requirement. 
                - User node pools allow you to set the node count for a pool to zero.

    3. Manage application demand in an AKS cluster
        - You can scale workloads on an AKS-managed cluster in one of two ways. 
            1. The first option is to scale the pods or nodes manually as necessary.
            2. The second option is through automation, where you can use the **horizontal pod autoscaler** to **scale pods** and the **cluster autoscaler** to **scale nodes**.

    4. How to scale a node pool manually
        - If you're running workloads that execute for a specific duration at specific known intervals, manually scaling the node pool size is a good way to control node costs.

        - Assume that the predictive-modeling service requires a GPU-based node pool and runs for an hour every day at noon.
            + You can configure the node pool with specific GPU-based nodes and scale the node pool to zero nodes when you're not using the cluster.

        - Here's an example of the **az aks node pool add** command that you can use to create the node pool.
            + Notice the **--node-vm-size** parameter, which specifies the **Standard_NC6** GPU-based VM size for the nodes in the pool.

            ```
            az aks nodepool add --resource-group resourceGroup --cluster-name aksCluster --name gpunodepool --node-count 1 --node-vm-size Standard_NC6 --no-wait
            ```

        - When the pool is ready, you can use the **az aks nodepool scale** command to scale the node pool to zero nodes. 
            + Notice that the **--node-count** parameter is set to zero.

            ```
            az aks nodepool scale --resource-group resourceGroup --cluster-name aksCluster --name gpunodepool --node-count 0
            ```

    5. How to scale a cluster automatically
        - AKS uses the Kubernetes cluster autoscaler to automatically scale workloads.
        - The cluster can scale by using two options:
            + 1. The horizontal pod autoscaler
            + 2. The cluster autoscaler

        1. Horizontal pod autoscaler
            - Use the Kubernetes horizontal pod autoscaler to monitor the resource demand on a cluster and automatically scale the number of workload replicas.

            - The Kubernetes Metrics Server collects memory and processor metrics from controllers, nodes, and containers that run on the AKS cluster. 
                + One way to access this information is to use the Metrics API. 
                + The horizontal pod autoscaler checks the Metrics API every 30 seconds to decide whether your application needs more instances to meet the required demand.

            - Assume your company also has a batch-processing service that schedules drone flight paths. 
                + You notice that the service gets inundated with requests and builds up a backlog of deliveries, causing delays and frustrations for customers.
                + Increasing the number of batch-processing service replicas could enable the timely processing of orders.

            - To solve the problem, you configure the horizontal pod autoscaler to increase the number of service replicas when needed. 
                + When the number of batch requests decrease, it decreases the number of service replicas.

            - However, the horizontal pod autoscaler scales pods only on available nodes in the configured node pools of the cluster.

        2. Cluster autoscaler
            - A resource constraint is triggered when the horizontal pod autoscaler can't schedule another pod on the existing nodes in a node pool.
            - You need to use the cluster autoscaler to scale the number of nodes in a cluster's node pools in times of constraints.
                + The cluster autoscaler checks the defined metrics and scales the number of nodes up or down based on the computing resources required.

            - The cluster autoscaler is used alongside the horizontal pod autoscaler.

            - The cluster autoscaler monitors for both scale-up and scale-down events, and allows the Kubernetes cluster to change the node count in a node pool as resource demands change.

            - You configure each node pool with different scale rules. 
                + For example, you might want to configure only one node pool to allow autoscaling, or you might configure a node pool to scale only to a specific number of nodes.

            - NOTE: You lose the ability to scale the node count to zero when you enable the cluster autoscaler on a node pool. 
                + Instead, you can set the min count to zero to save on cluster resources.

2. Exercise - Configure multiple nodes and enable scale-to-zero on an AKS cluster
    1. Step 1: Create a new resource group
        ```Azure CLI
        REGION_NAME=eastus
        RESOURCE_GROUP=rg-akscostsaving
        AKS_CLUSTER_NAME=akscostsaving-$RANDOM

        az group create --name $RESOURCE_GROUP --location $REGION_NAME
        ```
        - check: `echo $REGION_NAME`

    2. Step 2: Create the AKS cluster
        1. To get the Kubernetes version, run the **az aks get-versions** command
            ```Azure CLI
            VERSION=$(az aks get-versions --location $REGION_NAME --query "values[?isPreview==null].version | [-1]" --output tsv)
            
            echo $VERSION
            ```
        2. Run the **az aks create** command to create the AKS cluster
            ```
            az aks create --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --location $REGION_NAME --kubernetes-version $VERSION --node-count 2 --load-balancer-sku standard --vm-set-type VirtualMachineScaleSets --generate-ssh-keys
            ```
            - The cluster runs with two nodes in the system node pool.
            - Two important parameters:
                + **--load-balancer-sku standard**:
                    - The default load-balancer support in AKS is **basic**. 
                    - The basic load balancer isn't supported when you use multiple node pools. 
                    - Set the value to standard.
                + **--vm-set-type VirtualMachineScaleSets**
                    - To use the scale features in AKS, virtual machine scale sets are required. 
                    - This parameter enables support for scale sets.

        3. Run the **az aks nodepool list** command to list the node pools in your new cluster:
            ```
            az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME

                --> node pool's mode: System
            ```
            - NOTICE that the node pool's **mode** is set to **System** and that the **name** is automatically assigned.
            
    3. Step 3: Add a node pool
        1. Your cluster has a single node pool. Add a second node pool by running the az aks nodepool add command.
            + node-pool name: must start with a lowercase letter and contain only alphanumeric characters. 
                - limited to 12 characters for Linux, 6 for Windows.
            ```
            az aks nodepool add --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME --name batchprocpl --node-count 2
            ```
        2. Run the az aks nodepool list command to list the new node pool in your new cluster
            ```
            az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME

                --> node pool's mode: User
            ```
            - NOTICE that the **mode** of the new node pool is set to **User** and that the **name** is **batchprocpl**

    4. Step 4: Scale the node-pool node count to zero
        ```
        az aks nodepool scale --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME --name batchprocpl --node-count 0
        ```
        - Run the az aks nodepool scale command to scale nodes in a node pool manually.

    5. Step 5: Configure the Kubernetes context
        1. Run **kubectl** to interact with your cluster's API server. 
            - You have to configure a Kubernetes cluster context to allow kubectl to connect. 
            - The context contains the cluster's address, a user, and a namespace.
            - Run the **az aks get-credentials** command to configure the Kubernetes context in Cloud Shell.

            - Retrieve the cluster credentials by running this command:
                ```
                az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME

                    --> Merged "akscostsaving-17835" as current context in /home/user/.kube/config
                ```
        2. List the nodes in your node pools.
            ```
            kubectl get nodes
            ```
            - Notice that, even though the **az aks nodepool list** command lists two node pools,
                + there are only two nodes available in the cluster, and both are from **nodepool1**.

    - To optimize costs on AKS when you manage workload demands directly, a good strategy is to:
        + Manually scale the node count in node pools.
        + Scale expensive, NV-based user node pools to zero.

3. Configure multiple node pools by using AKS spot node pools with the cluster autoscaler
    - Azure provides Azure Virtual Machine instances that offer scalability while reducing costs, and are ideal for workloads that can be interrupted.
        + However, these virtual machines (VMs) access unused Azure compute capacity at lower prices but still support high-performance computing scenarios.

    - Your company's drone-tracking solution is deployed on Azure Kubernetes Service (AKS) as many containerized applications and services.
        + One of these services is a batch-processing service that schedules drone flight paths.
        + With a sudden growth in your customer base, the batch-processing service gets inundated with requests and builds up a backlog of deliveries.
        + This situation is causing delays and customer frustration.

    - Automatically scaling the number of batch-processing service replicas provides for timely order processing. 
        + However, it also requires you to deploy more nodes to keep up with computing resource needs.
        + Analyzing usage trends in Azure Monitor, you notice that these nodes are used only at specific times and not in a cost-effective way.
        + The batch-processing service is stateless and doesn't save any client-session data. 

    - You realize that you can save money by:
        + Using lower-cost node instances.
        + Automatically scaling the node count in the node pool that's configured for batch processing.

    1. What is a spot virtual machine (spot VM) in Azure?
        - A spot virtual machine is a VM that gives you access to unused Azure compute capacity at deep discounts. 
            + Spot VMs replace the existing, low-priority VMs in Azure. 
        - You can use spot VMs to run workloads that include:
            + High-performance computing scenarios, batch processing, or visual-rendering applications.
            + Large-scale, stateless applications.
            + Developer/test environments, including continuous integration (CI) and continuous delivery (CD) workloads.

        1. Spot VM availability
            - Spot VM availability depends on factors such as capacity, size, region, and time of day. 
                + Azure allocates VMs only if capacity is available. 
                + As a result, there's no service-level agreement (SLA) for these types of VMs, and they offer no high-availability guarantees.

        2. Spot VM eviction policy
            - The default eviction policy for spot VMs is **Deallocate**. 
                + Azure evicts spot VMs with 30 seconds of notice when capacity in a region becomes limited.
                + A VM that's set with the **Deallocate** policy moves to the stopped-deallocated state when evicted. 
                + You can redeploy an evicted VM when spot capacity becomes available again.
                + A deallocated VM is still counted toward your spot virtual CPU (vCPU) quota, and charges for the underlying allocated disks still apply.

    2. What is a spot virtual machine scale set?
        - A spot virtual machine scale set is a virtual machine scale set that supports Azure spot VMs.
        - These VMs behave the same way as normal spot VMs, 
            + but with one difference: when you use virtual machine scale set support for spot VMs in Azure,
            + you choose between two eviction policies:
                - 1. **Deallocate**: The Deallocate policy functions exactly as described earlier.
                - 2. **Delete**: The Delete policy allows you to avoid the cost of disks and hitting quota limits.
                    + With the Delete eviction policy, evicted VMs are deleted together with their underlying disks.

        - NOTICE: A best practice is to use the autoscale feature only when you set the eviction policy to **Delete** on the scale set.

    3. What is a spot node pool in Azure Kubernetes Service (AKS)?
        - A spot node pool is a user node pool that uses a spot virtual machine scale set. 
        - AKS supports spot VMs when you:
            + 1. Need to create user node pools.
            + 2. Want the cost benefits offered by virtual machine scale set support for Azure spot VMs.
        
        - Use spot node pools to:
            + 1. Take advantage of unused capacity in Azure.
            + 2. Use scale set features with the Delete eviction policy.
            + 3. Define the maximum price you want to pay per hour.
            + 4. Enable the recommended AKS Kubernetes cluster autoscaler when using spot node pools.

        - For example, to support the drone-tracking application's batch-processing service, you can create a spot user node pool and enable the cluster autoscaler. 
            + You can then configure the horizontal pod scaler to deploy more batch-processing services to match resource demands.

        - As the demand for nodes increases, the cluster autoscaler can scale the number of nodes up and down in the spot node pool. 
            + If node evictions happen, the cluster autoscaler keeps trying to scale up the node count if extra nodes are still needed.

    4. Spot node pool limitations
        - Before you decide to add a spot user node pool to your AKS cluster,
            + consider the following limitations:
                - 1. The underlying spot scale set is deployed only to a single fault domain and offers no high-availability guarantees.
                - 2. The AKS cluster needs multiple node-pool support to be enabled.
                - 3. You can use spot node pools only as user node pools.
                - 4. You can't upgrade spot node pools.
                - 5. The creation of spot VMs isn't guaranteed.
                    + The creation of spot nodes depends on capacity and quota availability in the cluster's deployed Azure region.

        - Remember that spot node pools should be used only for workloads that can be interrupted.

    5. Add a spot node pool to an AKS cluster
        - A spot node pool can't be a system node pool for an AKS cluster.
            + First, you need to create your cluster and then use the az aks nodepool add command to add a new user node pool.

        - You set several parameters for a new node pool to configure it as a spot node pool.

        1. Priority: Regular (default), Spot
            - The **--priority** parameter is set to **Regular** by default for a new node pool.
            - Set the value to **Spot** to indicate that the new pool you're creating is a spot node pool. 
            - Notice: this value can't be changed after creation.

        2. Eviction policy: Delete, Deallocate
            - A spot node pool must use a virtual machine scale set. 
            - Set **--eviction-policy** to **Delete** to allow the scale set to remove both the node and the underlying, allocated disk the node uses.
            - NOTICE: You can't change this value after creation.

            - You can set the eviction policy to **Deallocate**, but when these nodes are evicted,
                + they still count against your compute quota towards scaling or upgrading the cluster.

        3. Maximum price for spot node
            - Spot node pools optimize costs by capping the maximum amount that you're willing to pay per spot node per hour. 
                + To set your safe amount, use the **--spot-max-price** parameter.
                + Newly created spot nodes are evicted when this value is reached.

            - You can set this value to any positive amount up to five decimal places, or set it to **-1**.
            - Setting the **--spot-max-price** value to *-1* affects your node pool in the following ways:
                + 1. Nodes aren't be evicted based on the node's price.
                + 2. The cost for new nodes is based on the current price for spot nodes, or the price for a standard node, using whichever is lower.

            - For example, if you set the value to 0.98765, the maximum price for a node in USD is 0.98765 per hour. 
                + When the node's consumption exceeds this amount, it's evicted.

        4. Enable the cluster autoscaler
            - We recommend that you enable the cluster autoscaler by using the **--enable-cluster-autoscaler** parameter.
            - If you don't use the cluster autoscaler, 
                + you risk the node count dropping to zero in the node pool as nodes are evicted because of Azure capacity constraints.

        5. Minimum node count
            - Set the minimum node count to a value between 1 and 100 by using the **--min-count** parameter. 
            - NOTICE: A minimum node count is required when you enable the cluster autoscaler.

        6. Maximum node count
            - Set the maximum node count to a value between 1 and 100 by using the --max-count parameter. 
            - NOTICE: A maximum node count is required when you enable the cluster autoscaler.

        7. Sample Configuration
            - Here's an example **az aks nodepool add** command that adds a spot node pool with a max count of 3 and min count of 1. 
                + Notice the use of **--enable-cluster-autoscaler** to enable the spot node features.
                ```
                az aks nodepool add --resource-group resourceGroup --cluster-name aksCluster --name spotpool01 --enable-cluster-autoscaler --max-count 3 --min-count 1 --priority Spot --eviction-policy Delete --spot-max-price -1 --no-wait
                ```

    6. Deploy pods to spot node pools
        - When deploying workloads in Kubernetes, you can provide information to the scheduler to specify which nodes the workloads can or can't run.
        - You control workload scheduling by configuring **taints**, **toleration**, or **node affinity**.
        - Spot nodes are configured with a specific label and taint.


        1. What is a taint?
            - A taint is applied to a node to indicate that only specific pods can be scheduled on it.
            - Spot nodes are configured with a label set to **kubernetes.azure.com/scalesetpriority:spot**.
        2. What is toleration?
            - Toleration is a specification applied to a pod to allow, but not require, a pod to be scheduled on a node with the corresponding taint. 
            - Spot nodes are configured with a node taint set to **kubernetes.azure.com/scalesetpriority=spot:NoSchedule**.

        - NOTICE: Taints and tolerations don't guarantee a pod will be placed on a specific node. 
            + For example, if a node has no taint, then it's possible that the pod with the toleration might be scheduled on the untainted node.
            + Specifying an affinity with taints and tolerations can address this issue.

        3. What is node affinity?
            - You use node affinity to describe which pods are scheduled on a node. 
                + Affinity is specified by using labels defined on the node. 
            - For example, in AKS, system pods are configured with anti-affinity towards spot nodes to prevent the pods from being scheduled on these nodes.

    7. Define toleration in a pod manifest file
        - You specify node-taint toleration by creating a tolerations dictionary entry in your workload manifest file.
        - In this dictionary, you set the following properties for each node taint the workload has to tolerate in this section:
            + 1. **key**
                - Identifies a node taint key-value pair specified on the node.
                - For example, on a spot node pool, the key-value pair is **kubernetes.azure.com/scalesetpriority:spot**. 
                    + The key is **kubernetes.azure.com/scalesetpriority**.
            + 2. **operator**
                - Allows the toleration to match a taint. 
                - The default operator is *Equal*.
                - You can also specify *Exists* to match toleration. 
                - However, when you use *Exists*, you don't specify the following property (*value*).
            + 3. **value**
                - Represents the value part of the node-taint key-value pair that's specified on the node. 
                - For example, on a spot node pool with a key-value pair of **kubernetes.azure.com/scalesetpriority:spot**, the value is **spot**.
            + 4. **effect**
                - Indicates how the scheduling of a pod is handled in the system.
                - There are three options: *NoSchedule*, *PreferNoSchedule*, and *NoExecute*. 
                    + *NoSchedule* ensures that the system can't schedule the pod.
                    + *PreferNoSchedule* allows the system to try not to schedule the pod.
                    + *NoExecute* either evicts pods that are already running on the tainted node or doesn't schedule the pod at all.

    8. Define node affinity in a pod manifest file
        - You specify affinity by creating an affinity entry in your workload manifest file. 
        - In this entry, you set the following properties for each node label that a workload must match:
            + 1. **nodeAffinity**
                - Describes node affinity scheduling rules for the pod

            + 2. **requiredDuringSchedulingIgnoredDuringExecution**
                - If the affinity requirements specified by this field aren't met at scheduling time, the pod can't be scheduled onto the node.
                - If the affinity requirements specified by this field cease to be met at some point during pod execution (for example, due to an update),
                    + the system can choose to attempt to evict the pod from its node.
            + 3. **nodeSelectorTerms**
                - A list of node selector terms. 
                    + Terms returned match any of the filters, rather than all of the filters.

            + 4. **matchExpressions**
                - A list of node selector requirements by node's labels.

            + 5. **key**
                - The label key that the selector applies to. The key is **kubernetes.azure.com/scalesetpriority**

            + 6. **operator**
                - Represents a key's relationship to a set of values. 
                    + Valid operators are *In*, *NotIn*, *Exists*, *DoesNotExist*, *Gt*, and *Lt*

            + 7. **values**
                - Represents the value part of the node label key-value pair that is specified on the node.
                    + On a spot node pool with a key-value pair of **kubernetes.azure.com/scalesetpriority:spot**, the value is **spot**.

    - Here's an example of a workload that has toleration and affinity added for spot node pools
        ```yml
        apiVersion: v1
        kind: Pod
        metadata:
          name: nginx
          labels:
            env: test
        spec:
          containers:
          - name: nginx
              image: nginx
              imagePullPolicy: IfNotPresent
          tolerations:
          - key: "kubernetes.azure.com/scalesetpriority"
            operator: "Equal"
            value: "spot"
            effect: "NoSchedule"
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: "kubernetes.azure.com/scalesetpriority"
                    operator: In
                    values:
                    - "spot"
        ```


4. Exercise - Configure multiple node pools by using AKS spot node pools with the cluster autoscaler
    - Spot user node pools allow you to access unused Azure compute capacity at lower prices with support for high-performance computing scenarios.
    - In the previous exercise, you created a standard user node pool, used the cluster autoscaler to manage node creation, and scaled the node count manually.
    - The next step is for you to add a spot user node pool with automatic scaling to reduce your cluster's operational costs.
      + Cluster usage varies based on resources needed and isn't predictable, so you set up rules to capture the spikes and dips. 
      + The workload is deployed with node affinity enabled so that the pod is scheduled on nodes in the spot node pool.

    1. Step 1: Create a spot node pool
        - You need to create a separate node pool that supports the batch-processing service. 
        - This node pool is a spot node pool that uses the Delete eviction policy and a spot maximum price of -1.
        - 1. Step 1: Run the same **az aks nodepool add** command as in the previous exercise to add a new spot node pool to your cluster. 
            + You need to change the node pool name and add a few more parameters to identify this node pool as a spot node pool.
            + Enter the following values to set the node pool's parameters:
                - 1. Name: batchprocpl2
                - 2. Priority: Spot
                - 3. Eviction policy: Delete
                - 4. Spot maximum price: -1

            ```
            az aks nodepool add --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME --name batchprocpl2 --enable-cluster-autoscaler --max-count 3 --min-count 1 --priority Spot --eviction-policy Delete --spot-max-price -1 --node-vm-size Standard_DS2_v2 --no-wait
            ```
            - NOTICE: Keep in mind that this request might fail because of capacity restrictions in the location that you've selected.

        - 2. Step 2: Run the **az aks nodepool show** command to show the details of the new spot node pool for the batch-processing service:
            ```
            az aks nodepool show --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME --name batchprocpl2
            ```
            + A few values in this result are distinctly different from what you've seen in previous node pools. 
            + Let's review these items:
                - 1. The `enableAutoScaling` property value is set to true.
                - 2. Both the `maxCount` and `minCount` values are set.
                - 2. The `scaleSetEvictionPolicy` property is set to Delete.
                - 2. The `scaleSetPriority` property is set to Spot.
                - 2. The `spotMaxPrice` property is set to -1.
                - 2. The `nodeLabels` and `nodeTaints` are applied to this node pool. You use these values to schedule workloads on the nodes in the node pool.

                ```
                {
                    "agentPoolType": "VirtualMachineScaleSets",
                    "availabilityZones": null,
                    "count": 3,
                    "enableAutoScaling": true,
                    "enableNodePublicIp": false,
                    "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rg-akscostsaving/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/batchprocpl2",
                    "maxCount": 3,
                    "maxPods": 110,
                    "minCount": 1,
                    "mode": "User",
                    "name": "batchprocpl2",
                    "nodeImageVersion": "AKSUbuntu-1604-2020.06.10",
                    "nodeLabels": {
                        "kubernetes.azure.com/scalesetpriority": "spot"
                    },
                    "nodeTaints": [
                        "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
                    ],
                    "orchestratorVersion": "1.17.9",
                    "osDiskSizeGb": 128,
                    "osType": "Linux",
                    "provisioningState": "Creating",
                    "proximityPlacementGroupId": null,
                    "resourceGroup": "akscostsavinggrp",
                    "scaleSetEvictionPolicy": "Delete",
                    "scaleSetPriority": "Spot",
                    "spotMaxPrice": -1.0,
                    "tags": null,
                    "type": "Microsoft.ContainerService/managedClusters/agentPools",
                    "upgradeSettings": {
                        "maxSurge": null
                    },
                    "vmSize": "Standard_DS2_v2",
                    "vnetSubnetId": null
                }
                ```

    2. Step 2: Configure a namespace
        - Run the kubectl create namespace command to create a namespace called costsavings for the application. 
        - You'll use this namespace to make it easier to select your workloads.
            ```Bash
            kubectl create namespace costsavings

                --> namespace/costsavings created
            ```

    3. Step 3: Schedule a pod with spot node affinity
        - You can schedule a pod to run on a spot node by adding a toleration and an affinity to the pod's deployment manifest file. 
            + When the toleration and node affinity correspond with the taint and label applied to your spot nodes, the pod is scheduled on these nodes.

        - The nodes in a spot node pool are assigned a taint that equals **kubernetes.azure.com/scalesetpriority=spot:NoSchedule** and a label that equals **kubernetes.azure.com/scalesetpriority=spot**.
            + Use the information in this key-value pair in the **tolerations** and **affinity** section of your workloads YAML manifest file. 
            + With the second batch-processing pool configured as a spot node pool, you can now create a deployment file to schedule workloads to run on it.

        - 1. Step 1: Create a manifest file for the Kubernetes deployment called spot-node-deployment.yaml by using the integrated editor:
            ```Bash
            code spot-node-deployment.yaml
            ```
            - This command opens the editor without the file explorer.

        - 2. Step 2: Paste the following text into the file:
            ```
            apiVersion: v1
            kind: Pod
            metadata:
            name: nginx
            labels:
                env: test
            spec:
            containers:
            - name: nginx
                image: nginx
                imagePullPolicy: IfNotPresent
            tolerations:
            - key: "kubernetes.azure.com/scalesetpriority"
                operator: "Equal"
                value: "spot"
                effect: "NoSchedule"
            affinity:
                nodeAffinity:
                requiredDuringSchedulingIgnoredDuringExecution:
                    nodeSelectorTerms:
                    - matchExpressions:
                    - key: "kubernetes.azure.com/scalesetpriority"
                        operator: In
                        values:
                        - "spot"
            ```
        
        - 3. Step 3: Press Ctrl+S to save the file, then press Ctrl+Q to close the editor.
        - 4. Step 4: Run the **kubectl apply** command to apply the configuration and deploy the application in the **costsavings** namespace:
            ```Bash
            kubectl apply \
                --namespace costsavings \
                -f spot-node-deployment.yaml

                --> pod/nginx created
            ```

        - 5. Step 5: You can fetch more information about the running pod by using the **-o wide** flag when running **kubectl get pods** command.
            + In this case, you want to see which node the pod is scheduled on. 
            + Make sure to query for pods in the **costsavings** namespace.
            
            ```Bash
            kubectl get pods --namespace costsavings -o wide

                NAME    READY   STATUS    RESTARTS   AGE   IP           NODE                                   NOMINATED NODE   READINESS GATES
                nginx   1/1     Running   0          43s   10.244.3.3   aks-batchprocpl2-25254417-vmss000000   <none>           <none>
            ```
            - NOTICE the name of the node, **aks-batchprocpl2-25254417-vmss000000**.
                + This node is part of the **batchprocpl2** spot node pool that you created earlier.

5. Configure AKS resource-quota policies by using Azure Policy for Kubernetes
    - Azure Policy helps you to enforce standards and assess compliance at scale for your cloud environment. 
        + It's good practice for companies to implement business rules to define how employees are allowed to use company software, hardware, and other resources in the organization.
        + Therefore, businesses use policies to enforce, review, and define access.
        + A policy helps an organization meet governance and legal requirements, implement best practices, and establish organizational conventions.

    - Azure Kubernetes Service (AKS) allows you to orchestrate your cloud-native applications efficiently with policies.
        + You realize that you need to enforce business rules to manage how the teams use AKS to ensure a cost-effective approach. 
        + You decide to use Azure Policy to apply this idea on your Azure-based cloud resources.

    - Before discussing how to use Azure Policy for Kubernetes, you should understand a few more concepts that enable this feature from within Kubernetes.

    1. What is a Kubernetes admission controller?
        - An admission controller is a Kubernetes plug-in that intercepts authenticated and authorized requests to the Kubernetes API before the requested Kubernetes object's persistence. 
        - For example, suppose you deploy a new workload, and the deployment includes a pod request with specific memory requirements. 
            + The admission controller intercepts the deployment request and must authorize the deployment before it's persisted to the cluster.

        - You can think of an admission controller as software that governs and enforces how the cluster is used and designed. 
            + It limits requests to create, delete, and modify Kubernetes objects.

    2. What is an admission-controller webhook?
        - An admission-controller webhook is an HTTP callback function that receives admission requests and then acts on these requests. 
            + Admission controllers need to be configured at runtime. 
            + These controllers exist either for your compiled-in admission plug-in or a deployed extension that runs as a webhook.

        - Admission webhooks are available in two kinds: either a *validating webhook* or a *mutating webhook*.
            + A mutating webhook is invoked first and can change and apply defaults on the objects sent to the API server. 
            + A validation webhook validates object values and can reject requests.

    3. What is the Open Policy Agent (OPA)?
        - The Open Policy Agent (OPA) is an open-source, general-purpose policy engine that gives you a high-level declarative language to author policies.
            + These policies allow you to define rules that oversee how your system should behave.


    4. What is the OPA Gatekeeper?
        - The OPA Gatekeeper is an open-source, validating, Kubernetes admission-controller webhook that enforces Custom Resource Definition (CRD)-based policies that follow the OPA syntax.

        - The goal of the OPA Gatekeeper is to allow you to customize admission policies by using configuration instead of hard-coded policy rules for services.
            + It also gives you a full view of your cluster to identify policy-violating resources.

        - Use the OPA Gatekeeper to define organization-wide policies with rules:
            + 1. The maximum resource limits, such as CPU and memory limits, are enforced for all configured pods.
            + 2. The deployment of images is allowed only from approved repositories.
            + 3. Naming convention for labels for all namespaces in a cluster must specify a point of contact for each namespace.
            + 4. Mandate that cluster services have globally unique selectors.

    5. Azure Policy for AKS
        - Azure Policy extends OPA Gatekeeper version 3 and integrates with AKS through built-in policies. 
            + These policies apply at-scale enforcements and safeguards on your cluster in a centralized and consistent manner.

        - Your company's development teams want to optimize development and introduce development tools such as DevSpaces to simplify their Kubernetes development workflow. 
            + You want to make sure that the team members adhere to specific resource limits for their projects. 
            + You decide to put a policy in place that defines the compute resources, storage resources, and object count permitted in the development namespaces.

        - To set up resource limits, you can apply resource quotas at the namespace level and monitor resource usage to adjust policy quotas.
            + Use this strategy to reserve and limit resources across the development team.

    6. How to enable the Azure Policy Add-on for AKS
        - There are a few steps to registering the Azure Policy Add-on for AKS feature.
        - 1. Step 1: Register two resource providers by using the az provider register command:
            ```
            az provider register --namespace Microsoft.ContainerService
            az provider register --namespace Microsoft.PolicyInsights
            ```
            + **Microsoft.ContainerService** and **Microsoft.PolicyInsights**: These resource providers support actions such as querying information about policy events and managing containers. 
                - These are actions to query, create, update, or delete policy remediation.
        
        - 2. Step 2: Register the **AKS-AzurePolicyAutoApprove** feature with the **Microsoft.ContainerService** resource provider. 
            + Here's an example of the command:
                ```
                az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
                ```
        - 3. Step 3: After you confirm the successful feature registration, run the az provider register command with the --namespace parameter to propagate the new feature registration.
            + Here's an example of the command:
                ```
                az provider register -n Microsoft.ContainerService
                ```

        - 4. Step 4: Enable the azure-policy add-on:
            ```
            az aks enable-addons --addons azure-policy --name myAKSCluster --resource-group myResourceGroup
            ```

        - Activating the addon schedules workloads in two namespaces on your cluster. 
            + The first namespace is **kube-system**, which contains the **azure-policy** and *azure-policy-webhook*.
            + The second namespace is **gatekeeper-system**, which contains the **gatekeeper-controller-manager**.
            + These workloads are responsible for evaluating requests submitted to the AKS control plane.
            + Based on your configured policies, your policy webhook can allow or deny requests.

    7. Assign a built-in policy definition
        - You manage your Azure environment's policies by using the Azure policy compliance dashboard. 
            + The dashboard allows you to drill down to a per-resource, per-policy level of detail.
            + It helps you bring your resources to compliance by using bulk remediation for existing resources and automatic remediation for new resources.

        - For each policy, the following overview information is listed:
            + 1. **Name**: The name of the policy
                - Ex: Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster.
            + 2. **Scope**: The subscription resource group to which this policy applies.
                - Ex: mySubscription/rg-akscostsaving.
            + 2. **Compliance state**: The status of assigned policies.	
                - Ex: Compliant, Conflicted, Not started, or Not Registered.

            + 2. **Resource compliance**: The percentage of resources that comply with the policy. 
                - This calculation takes into account compliant, non-compliant, and conflicting resources.	
                - Ex: 100
            + 2. **Non-compliant resources**: The number of unique resources that violate one or more policy rules.
                - Ex: 3
            + 2. **Non-compliant policies**: The number of non-compliant policies.
            - Ex: 5

        - From here, you can drill down into the per-resource and per-policy details for the events triggered.
            + For example, you can examine details of a denied workload deployment.

        1. Assigning policies
            - To assign a policy, select the **Assignments** option under the **Authoring section** in the Azure Policy navigation panel.
            - You assign Azure policies in one of two ways: as a group of policies called an **initiative**, or as a single policy.

        2. Initiative assignment
            - An initiative assignment is a collection of Azure policy definitions grouped together to satisfy a specific goal or purpose. 
            - For example, the goal might be to apply the Payment Card Industry Data Security Standard across your resources.

        3. Policy assignment
            - A policy assignment assigns a single policy, such as **Do not allow privileged containers in Kubernetes cluster**.

    8. How to assign a policy
        - Each policy is defined by using a series of configuration steps.
            + The amount of information you capture depends on the type of policy you select.

        - For example, to limit resource deployment by developers in the company's cloud environment, you can assign one of the built-in Azure policies for Azure Kubernetes Service. 
            + The name of the policy is **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster**.
        
        - The policy requires you to set the limit on the allowed resources requested by deployment requests.

        1. Basic policy information
            - The first step requires you to select and enter basic information that defines the new policy.
            - For example, this information can be the policy and the resource scope. 
            - This table shows each item you can configure:
                + 1. Scope: The scope determines on what resources or group of resources the policy assignment is enforced. 
                    - This value is based on a subscription or a management group. 
                    - You can exclude resources from your selection at one level lower than the scope level.
                + 2. Policy Definition: The policy you want to apply. You can choose from several built-in policy options.
                + 3. Assignment name: The name used to identify the assigned policy.
                + 4. Description: A free-text description that describes the policy.
                + 5. Policy enforcement: You can choose *Enabled* and *Disabled*.
                    - If the option is Disabled, the policy isn't applied and requests aren't denied with non-compliance.
                + 6. Assigned by: A free-text value that defaults to the registered user. You can change this value.

        2. Policy parameters
            - Policies require you to configure the business rules that apply to each specific policy. 
                + Not all policies have the same business rules, and that's why each policy has different parameters.

            - For example, the **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster** policy requires you to set three parameters:
                + 1. The maximum CPU units allowed for a container
                + 2. The maximum memory bytes allowed for a container
                + 3. A list of Kubernetes namespaces to exclude from the policy

            - Compare that policy with the **Web Application should only be accessible over HTTPS** policy,
                + which has no custom parameters to configure.

            - All policies have an **Effect** setting. 
                + This setting enables or disables the policy execution. 
                + As with parameters, policies can also have different **Effect** options.

            - For example, for the resource-management policy, you can select *audit*, *deny*, or *disable* as the Effect value.
                + For the web-application policy, you can select only *audit* or *disable*.

            - This table lists all the **effects** currently supported in policy definitions:
                + 1. **Append**: Adds more fields to the requested resource
                + 2. **Audit**: Creates a warning event in the activity log
                + 2. **AuditIfNotExists**: Enables auditing of resources related to the resource that matches the condition
                + 2. **Deny**: Prevents a resource request that doesn't match defined standards through a policy definition, and fails the request
                + 2. **DeployIfNotExists**: Executes a template deployment when the condition is met
                + 2. **Disabled**: Useful for testing situations or for when the policy definition has parameterized the effect, and you want to disable a single assignment
                + 2. **Modify**: Adds, updates, or removes tags on a resource during creation or update

        3. Policy remediation
            - The final step is to consider policy remediation.
                + When you assign policies, it's possible that resources already exist and violate the new policy. 
                + By default, only newly created resources are applied to the new policy.
                + Use remediation to check existing resources after you assign a new policy. 
                + Remediation tasks can differ depending on the types of policies applied.

6. Exercise - Configure AKS resource-quota policies by using Azure Policy for Kubernetes
    - Azure Policy for Kubernetes helps organizations meet governance and legal requirements, implement best practices, and establish organizational conventions for cloud environments.
    - Development teams in your company are embracing Azure Kubernetes Service (AKS) as a development platform. 
        + You realize that the best way to manage costs is by enforcing business rules that define workload-resource limits. 
        + You want to make sure developers can deploy workloads only within specific limits for CPU and memory allocation. 
        + The system must prevent workloads that exceed those limits.

    1. Step 1: Enable the ContainerService and PolicyInsights resource providers
        1. Azure Policy for AKS requires the cluster version to be 1.14 or later. 
            - Run the following script to validate your AKS cluster version:
                ```
                az aks list
                ```
                + Make sure that the reported cluster version is 1.14 or later

        2. Register the Azure Kubernetes Service provider by running the **az provider register** command:
            ```
            az provider register --namespace Microsoft.ContainerService
            ```

        3. Register the Azure Policy provider by running the **az provider register** command:
            ```
            az provider register --namespace Microsoft.PolicyInsights
            ```

        4. Enable the add-on installation by running the **az feature register** command:
            ```
            az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
            ```

        5. Check that the registration was successful by querying the feature-list table. 
            - Use the **az feature list** command to run the query. 
            - The feature's registration can take several minutes to finish, so you have to check the result periodically.

            ```Azure CLI
            az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/AKS-AzurePolicyAutoApprove')].   {Name:name,State:properties.state}"
            ```
            - NOTICE: If the Cloud Shell session times out, you can track the registration process via the Azure portal by using the **preview onboarding pane**.
                + preview onboarding pane: https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/JoinPreview/?azure-portal=true

        6. Run the **az provider register** command to propagate the update after you confirm that the feature-list query command shows 'Registered':
            ```
            az provider register -n Microsoft.ContainerService
            ```

    2. Step 2: Enable the Azure Policy on your cluster
        1. Run the **az aks enable-addons** command to enable the **azure-policy** add-on for your cluster:
            ```Azure CLI
            az aks enable-addons --addons azure-policy --name $AKS_CLUSTER_NAME --resource-group $RESOURCE_GROUP
            ```
        2. Verify that the azure-policy pod is installed in the **kube-system** namespace and that the gatekeeper pod is installed in the **gatekeeper-system** namespace. 
            - To do so, run the following **kubectl get pods** commands:
                ```Bash
                kubectl get pods -n kube-system
                    --> NAME                                    READY   STATUS    RESTARTS   AGE
                        azure-policy-78c8d74cd4-7fqn2           1/1     Running   0          12m
                        azure-policy-webhook-545c898766-gsjrc   1/1     Running   0          12m
                
                kubectl get pods -n gatekeeper-system
                    --> NAME                                            READY   STATUS    RESTARTS   AGE
                        gatekeeper-controller-manager-d5cd87796-5tmhq   1/1     Running   0          15m
                ```
        3. Finally, verify that the latest add-on is installed by running **az aks show** command.
            - This command retrieves the configuration information for your cluster.

            ```Azure CLI
            az aks show --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME -o table --query "addonProfiles.azurepolicy"

                --> {
                        "config": null,
                        "enabled": true,
                        "identity": null
                    }
            ```

        - You're now ready to switch to the Azure portal to configure the policy named **Kubernetes cluster containers CPU and memory resource limits should not exceed the specified limits**.

    3. Step 3: Assign a built-in policy definition
        - To configure the new Azure Policy, use the Policy service in the Azure portal.
        - Step 1. Locate the **Policy** service in the Azure portal.
            - To do so, in the search bar at the top of the portal, search for and select **Policy**.
            - The Policy dashboard opens with an overview that shows all your assigned policies, the status of resources, 
                + and how the policies affect them. 
                + If you haven't assigned any policies, the dashboard is empty.

        - Step 2. In the left menu pane, under **Authoring**, select **Assignments**:

        - Step 3. Recall from our previous description that you have two options to create a policy assignment: you assign either an **initiative** or a **policy**. 
            + In the top menu bar, select **Assign policy**:

        - Step 4. On the **Basics** tab, enter the following values for each setting to create your policy.
            + **Scope**	
                - **Scope**: Select the ellipsis button. The **Scope** pane appears. 
                    + Under **subscription**, select the subscription that holds your resource group.
                    + For **Resource Group**, select **rg-akscostsaving**, then select the **Select** button.
                - **Exclusions**: Leave empty.

            + **Basics**	
                - **Policy definition**: Select the ellipsis button. The **Available Definitions** pane appears.
                    + In the **Search** box, filter the selection by entering *CPU*. On the **Policy Definitions** tab, 
                        - select the **Kubernetes cluster containers CPU and memory resource limits should not exceed the specified limits**,
                            + then select **Add**.
                - **Assignment name**: Accept default.
                - **Description**: Leave empty.
                - **Policy enforcement**: Make sure this option is set to **Enabled**.
                - **Assigned by**: Accept default.

        - Step 5. Select the **Parameters** tab to specify the parameters for the policy.
        - Step 6. Set the following values for each of the parameter settings:
            + **Max allowed CPU units**: Set the value to **200m**. 
                - The policy matches this value to both the workload resource-request value and the workload limit value specified in the workload's manifest file.
            
            + **Max allowed memory bytes**: Set the value to **256Mi**. 
                - The policy matches this value to both the workload resource-request value and the workload limit value specified in the workload's manifest file.

        - Step 7. Select the **Remediation** tab. 
            + In this tab, you'll select how the new policy impacts resources that already exist.
            + By default, the new policy only checks newly created resources. 
            + Keep the standard default configuration.

        - Step 8. Select the *Review + create* tab. Review the values you've chosen, then select **Create**.

        - IMPORTANT: If you're using an existing AKS cluster, the policy assignment might take about 15 minutes to apply.

    4. Step 4: Test resource requests
        - The final step is to test the new policy.
            + Deploy your test workload with resource requests and limits that violate the new policy. 
            + If all goes correctly, the server returns an error stating denied by policy.

        - Step 1. Open Azure Cloud Shell and be sure to select the Bash version of Cloud Shell.
        - Step 2. Create a manifest file for the Kubernetes deployment by using the integrated editor. 
            + Call the file **test-policy.yaml**:
                ```Bash
                code test-policy.yaml

                    --> open editor without file explorer.
                        Ctrl+Q to quit editor
                ```
                ```
                apiVersion: v1
                kind: Pod
                metadata:
                name: nginx
                labels:
                    env: test
                spec:
                    containers:
                    - name: nginx
                        image: nginx
                        imagePullPolicy: IfNotPresent
                        resources:
                            requests:
                                cpu: 500m
                                memory: 256Mi
                            limits:
                                cpu: 1000m
                                memory: 500Mi
                ```

        - Step 3. Run the **kubectl apply** command to apply the configuration and deploy the application in the **costsavings** namespace:
            ```Bash
            kubectl apply --namespace costsavings -f test-policy.yaml

                --> output
                Error from server (
                [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> memory limit <500Mi> is higher than the maximum allowed of <256Mi>
                [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> cpu limit <1> is higher than the maximum allowed of <200m>)
                : error when creating "test-deploy.yml"
                : admission webhook "validation.gatekeeper.sh" denied the request: 
                [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> memory limit <500Mi> is higher than the maximum allowed of <256Mi>
                [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> cpu limit <1> is higher than the maximum allowed of <200m>
            ```
            + NOTICE how the admission webhook, **validation.gatekeeper.sh**, denied the request to schedule the pod.

        - Step 4. Open the manifest file and fix the resource request:
            ```Bash
            code test-policy.yaml
                --> Ctrl+Q to quit editor after update
            ```
            ```
            apiVersion: v1
            kind: Pod
            metadata:
            name: nginx
            labels:
                env: test
            spec:
            containers:
            - name: nginx
                image: nginx
                imagePullPolicy: IfNotPresent
                resources:
                requests:
                    cpu: 200m
                    memory: 256Mi
                limits:
                    cpu: 200m
                    memory: 256Mi
            ```
        - Step 5. Run the **kubectl apply** command to apply the configuration and deploy the application in the **costsavings** namespace:
            ```
            kubectl apply --namespace costsavings -f test-policy.yaml

                --> pod/nginx created
            ```

        - Step 6. Get the pods of the newly created pods in your costsavings namespace.
            ```
            kubectl get pods --namespace costsavings

                --> Within a few seconds, the pods transition to the Running state
                    NAME    READY   STATUS    RESTARTS   AGE
                    nginx   1/1     Running   0          50s
            ```

        - Step 7. Press **Ctrl+C** to stop watching once you see the pods running

7. Summary
    - In this module, you explored strategies to optimize Azure Kubernetes Service (AKS) compute costs. 
         + You were looking for ways to manage the cost-effective deployment of many workloads to meet customer demands and apply policies. 
         + You automated the process to introduce business policies that govern how your development teams shape how your org uses AKS compute resources.

    - By configuring **multiple node pools** on your AKS cluster, you identified specific **user node pools** to run specific workloads. 
        + You saw how to configure these node pools and manually scale the node count in scenarios where you have control over usage intervals.

    - Next, you configured a **spot user node pool** to access unused Azure compute capacity at a discount price.
        + You built scheduled workloads to run in the node pool. 
        + You configured the **cluster autoscaler** to scale the number of nodes up or down based on computing resource requirements. 
        + This configuration handles increased customer demands without creating many nodes that aren't used.

    - Finally, you enabled and configured the Azure Policy Add-on for AKS.
        + The add-on manages resource quotas to govern the deployment of AKS compute resources.
        + You enabled the built-in **Ensure CPU and memory resource limits** policy. 
        + This policy configures parameters to deny workloads that exceed predefined resource limits for CPU and memory.

    - AKS makes it simple to deploy a managed Kubernetes cluster in Azure and to optimize computing costs when many workloads are running.


8. Clean up paid resources
    - In this module, you created billed resources on your Azure subscription.
    - The following steps show you how to clean up these resources so that there's no continued charge against your account.

    - 1. step 1: Delete resource group **rg-akscostsaving**
    - 2. step 2: run the **kubectl config delete-context** command to remove the deleted cluster's context
        ```Bash
        kubectl config delete-context akscostsaving-17835

            --> deleted context akscostsaving-17835 from /home/user/.kube/config
        ```

    - 3. step 3: Optional: Clean up services
        + In this module, you also registered service providers within Azure to access their features. 
        + There's no extra charge for registering the providers or features.
        + Follow these steps to unregister.
            1. Run the following command to unregister the Azure Policy on AKS feature.
                ```
                az feature unregister --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
                ```

            2. Repeat for the Azure providers
                az provider unregister --namespace Microsoft.PolicyInsights
                az provider unregister --namespace Microsoft.ContainerService
                ```

            - IMPORTANT: If you choose to unregister, then the optimization features covered in the learning module aren't able until you register.

9. Learn more
    - Create node pools for a cluster in Azure Kubernetes Service (AKS)
        + https://learn.microsoft.com/en-us/azure/aks/create-node-pools

    - Add a spot node pool to an Azure Kubernetes Service (AKS) cluster
        + https://learn.microsoft.com/en-us/azure/aks/spot-node-pool

    - Automatically scale a cluster to meet application demands on Azure Kubernetes Service (AKS)
        + https://learn.microsoft.com/en-us/azure/aks/cluster-autoscaler

    - Understand Azure Policy for Kubernetes clusters
        + https://learn.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes

    - Taints and Tolerations
        + https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

    - Best practices for advanced scheduler features in Azure Kubernetes Service (AKS)
        + https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-advanced-scheduler

    - Baseline architecture for an Azure Kubernetes Service (AKS) cluster
        + https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks
