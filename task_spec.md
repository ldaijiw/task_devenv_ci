# Jenkins CI Lab

## Timings

This lab last 30 - 60 Minutes

## Summary

Amazing! Our CI now only listens to dev or development branches, it also notifyies us of the outcome and is also being built in a machine that looks like our dev. environment! This is great!

Now that we know the code works, we want it to be merged on github. This is a second job - that should listen to the previous one and merge/publish the code.

This is a low level of delivery in the CI/CD world. Code is work and is delivered to the source of truth that is github.


## Tasks

* Configure your job to checkout code from the develop branch rather than the master branch
* Test should run to confirm the new work from the developers is stable
* The team should be notified of the results via either:
 - Teams - DON'T NOTIFY EVERYONE - **ASK TRAINER WHICH CHANNEL TO NOTIFY ON**
 - Email

**Make a new job:**
* Have the job merge the develop branch code with the master branch and test against that
* Use the Github plugin to set the commit status on github for the latest commit
* Use the Git publisher plugin to push the master branch to Github if the tests pass.

## Tips

All of these items are simple configuration provided by plugins that are already installed and setup on our Jenkins instance. If you are writing code you are doing it wrong.

You will need to research how these plugins works:

* The Github plugin
* The Git publisher plugin
* The email notification plugin
* Office 365 connector


## Acceptance Criteria

**for repo on github and dev env**

- repo exists on github
- Uses vagrant file to create local dev Env
- Localhost set to development.local
* port 80 has App running (you see the sparta logo on development.local)
* Work with only command "vagrant up" &/or mininum commands
* All tests passing

* Documentation exists as README.md file
* Documentation includes: Intro (purpose of repo), Pre Requisits  and Intructions
* Instructions have a clear step by step

**for first job on jenkins**

-  Automation server is listining and triggers build on branches :
  -  dev*
  -  devlopment*
- Webhooks are setup
- Notifications of tests sent to team via teams or email
- Test are executed in agent node

**for second job on jenkins**

* A second job is listining to the success of the previous job
* Job is to merge code and published (delivered to github) if build is sucessfull
* notification is sent to team via Teams

