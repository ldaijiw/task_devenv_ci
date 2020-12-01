# Sparta NodeJs Sample App DevEnv and CI

Jenkins is an open source automation server used within DevOps to set up CI/CD (Continuous Integration/Continuous Delivery) pipelines that helps to automate testing of new code, providing feedback within seconds, ensuring teams deliver high quality code by the time it is approved for deployment.

This repository uses virtual machines (VM) that contain a development environment to run a Sample App with Node.js, as well as instructions on setting up the first stages of a pipeline on Jenkins.

## Pre-Requisites

- Vagrant
- Virtual Box
- Ruby

[More information on installing and setting up pre-requisites](https://github.com/ldaijiw/vagrant_setup)

## Instructions

### Local Development Environment

In the ``code`` directory there are several key files/directories
- ``Vagrantfile``: Contains all the set up and provisioning instructions when ``vagrant up`` is run
- ``app``: Contains all of the Javascript code for the sample app
- ``environment``: Contains the bash scripts used to make any necessary installations and commands in the VM without requiring the user to SSH into the vagrant machine
- ``nginx_config``: Contains the configuration file to be used in the set up of a reverse proxy with _nginx_
- ``tests``: Contains Ruby tests to verify the VM is configured correctly

With an open terminal, navigate to the ``code`` directory and run
```bash
vagrant up
```

This will set up the database and app VMs, and once the set up is complete the app can be viewed at ``http://development.local``

### Setting Up Testing with Ruby

Testing is carried out with the **Rake** testing framework with **Ruby**, used to ensure that everything is set up and running correctly.

- In ``starter-code/environment/`` there is the ``spec-test`` folder which contains:
	- ``spec`` which contains the specific unit tests that ``rspec`` will refer to
	- ``Gemfile`` which contains a list of gems (packages) that must be installed in order to run the tests
	- ``Rakefile`` which contains the set of instructions to execute the tests
	- ``.rspec`` which can be ignored for now


**In order to install all the gems listed in Gemfile, first install bundler**

- Bundler is Ruby's package manager, which can be installed in terminal with
```bash
gem install bundler
```
- After this is successfully carried out, ensure that the terminal's current working directory is ``starter-code/environment/spec-test`` so that it can refer to the ``Gemfile`` and run
```bash
bundle
```
- This will install all the gems listed in ``Gemfile``, the tests are now ready to be run with
```bash
rake spec
```

If the app is configured correctly, these should all pass.

## Setting Up a Job in Jenkins

Create a new Item in Jenkins, for now selecting _Freestyle Project_, where there are several settings to configure

### General
- **Description**: optional
- **Discard old builds**: turn on with 2 (optional) max number of builds to keep
- **GitHub project**: project url (e.g. ``https://github.com/user/repo_name``)

### Office 365 Connector
- **Restrict where this project can be run**: logical expression to specify which agent to execute builds of the project (e.g. ``sparta-ubuntu-node``)

### Source Code Management

Select **Git**, this is where the connection to the GitHub repository can be configured

- **Repository URL**: URL for repo found in _Code_-->_Clone_-->_SSH_ (e.g. ``git@github.com:user/repo_name.git``)
- **Credentials**: This is where the SSH key is added

**SSH Keys with Jenkins and Github**

- Navigate to directory where SSH keys are stored with
```bash
cd ~/.ssh
```
- Generate a new SSH key with
```bash
ssh-keygen -t ed25519
```
- Enter the file name to save the key to after being prompted, and leave the passphrases empty
- Add the private key (file with no ``.pub`` extension) to GitHub (_Settings_-->_SSH and GPG keys_-->_New SSH key_)
- Add the public key (file with ``.pub`` extension) to Jenkins by _adding a key_
![](images/jenkins_credentials.png)

- **Branches to build**: specify which branch to build, (e.g. ``*/main``)

### Build Triggers

- **GitHub hook trigger for GITScm polling**: Check this option to trigger Jenkins to build when detecting pushes from the GitHub repository

### Setting Up a Webhook

The final step is crucial to setting up the communication between GitHub and Jenkins.

Setting up the webhook allows GitHub to trigger Jenkins to start a new build whenever a new commit is pushed.

In the GitHub repository that is to be linked to Jenkins, create a new Webhook (_Settings_-->_Webhooks_-->_Add webhook_)

- **Payload URL**: Add the URL (usually specified with ip and port) with ``/github-webhook/`` appended at the end
- **Content type**: Select ``application/json``

Any new pushes to the repository should now trigger a new build, shown in _Build History_ where the _Console Output_ can be read for each individual build
### Setting Up Jenkins and MS Teams

### Jenkins and Git Branching

```bash
git remote show origin

* remote origin
  Fetch URL: https://github.com/user/repo.git
  Push  URL: https://github.com/user/repo.git
  HEAD branch: main
  Remote branch:
    main tracked
  Local branch configured for 'git pull':
    main merges with remote main
  Local ref configured for 'git push':
    main pushes to main (up to date)
```
