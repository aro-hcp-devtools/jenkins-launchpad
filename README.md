# 🚀 Jenkins Launchpad

This project provides a containerized Jenkins environment that simplifies and automates the setup of personal development infrastructure for developers working on the Azure Red Hat OpenShift Hosted Control Planes (ARO-HCP) project.


## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│                 │    │                  │    │                 │
│     Nginx       │───▶│     Jenkins      │───▶│  Custom Agent   │
│ (Reverse Proxy) │    │    (Master)      │    │    (Docker)     │
│                 │    │                  │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         │                       ▼                       │
    Port 80/443          ┌──────────────────┐      Quay.io Registry
    SSL Termination      │ Microsoft Entra  │      Custom Tools
                         │  ID (OAuth2)     │
                         │ Authentication   │
                         └──────────────────┘
                                 │
                           Port 8080/50000
                           Jenkins Dashboard
```

### Components

- **Jenkins Master**: Jenkins instance with ARO-HCP development pipelines.
- **Nginx Reverse Proxy**: Handles SSL termination and secure access to Jenkins
- **Custom Build Agent**: Docker agent pre-loaded with ARO-HCP development tools (Azure CLI, Python, Go, etc.)
- **Microsoft Entra ID**: OAuth2 authentication provider for secure user authentication and access control
- **Azure Integration**: Automated Azure subscription management and Bicep template deployment for personal dev environments


## 🔧 Usage

### Personal Development Setup Pipeline

The `make-infra` pipeline automates your personal ARO-HCP development environment setup:


### Project Structure
```
jenkins-launchpad/
├── docker-compose.yml          # Container orchestration
├── jenkins/                    # Jenkins configuration
│   ├── Dockerfile.jenkins      # Jenkins master image
│   ├── Dockerfile.custom-agent # Custom build agent
│   ├── jenkins.yaml           # Jenkins CasC configuration
│   └── plugins.txt            # Required Jenkins plugins
├── nginx/                     # Reverse proxy configuration
│   └── conf.d/default.conf    # Nginx SSL configuration
├── pipelines/                 # Jenkins pipeline definitions
│   └── make-infra            # Infrastructure deployment pipeline
├── scripts/                   # Azure deployment scripts
│   ├── jenkins-server.bicep   # Main Bicep template
│   ├── infrastructure.bicep   # Infrastructure resources
│   └── init-script.sh        # VM initialization script
└── Makefile                  # Deployment automation
```

---

**Happy ARO-HCP Development! 🎉**