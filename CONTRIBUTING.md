# Contributing to Schedules

We would love for you to contribute to Schedules and help make it even better 
than it is today! As a contributor, here are the guidelines we would like you to
follow:

 - [Question or Problem?](#question)
 - [Issues and Bugs](#issue)
 - [Feature Requests](#feature)
 - [Coding Style](#style)
 - [Submission Guidelines](#submit)
 - [Submitting a Pull Request](#submit-pr)

## <a name="question"></a> Got a Question or Problem?

Please, do not open issues for the general support questions as we want to keep 
GitLab issues for bug reports and feature requests. You've got much better 
chances of getting your question answered on [Slack Group][slack] where 
questions should be asked in their respective channels.

## <a name="issue"></a> Found a Bug?

If you find a bug in the source code, you can help us by
[submitting an issue](#submit-issue) to our [GitLab Repository][gitlab]. Even 
better, you can [submit a Merge Request](#submit-pr) with a fix.

## <a name="feature"></a> Missing a Feature?

You can *request* a new feature by [submitting an issue](#submit-issue) to our 
GitLab Repository. If you would like to *implement* a new feature, please ensure
an issue already exists to be associated with your commits.

* For any **contribution**, first [open an issue](#submit-issue) and outline your proposal so that it can be
discussed. This will also allow us to better coordinate our efforts, prevent duplication of work,
and help you to craft the change so that it is successfully accepted into the project.

## <a name="style"></a> Coding style

The style for this project is the [Relaxed Ruby Style](http://relaxed.ruby.style), which is a subset of the community-driven [Ruby style guide](https://github.com/bbatsov/ruby-style-guide) with more relaxed rules.  

A great tool for making sure your code meets the project's style is [RuboCop](https://github.com/bbatsov/rubocop). To use RuboCop, install it by running the command  
    
    gem install rubocop
    
Then, when inside the `/schedules/` directory, you can run the command `rubocop` to see where your style does not match the project's.

## <a name="submit"></a> Submission Guidelines

### <a name="submit-issue"></a> Submitting an Issue

Before you submit an issue, please search through open issues, maybe an issue for 
your problem already exists and the discussion might inform you of workarounds 
readily available.

We want to fix all the issues as soon as possible, but before fixing a bug we 
need to reproduce and confirm it. In order to reproduce bugs we may 
ask you to describe a use-case that fails to assist in the debugging process. 

In GitLab there are issue templates that you can use which paste in a sample 
format for you to use.

Check out the following issue for an example: [https://git.gmu.edu/srct/schedules/issues/11](https://git.gmu.edu/srct/whats-open/issues/31)

You can file new issues by filling out our [new issue form][new-issue].

### <a name="submit-pr"></a> Steps to contribute and submit a Merge Request (MR)

Before you submit your Merge Request (MR) consider the following steps:

* Search [GitLab][merge-request] for an open or closed MR that relates to your 
    submission. You don't want to duplicate effort.

* Pull the latest commits from GitLab

    ```sh
    git pull
    ```

* Check into the current development branch:

    All new commits are merged into this development branch before going live on
    the site in a tagged release (merge into master branch). 
    
    ```sh
    git checkout consolidation
    ```

* Create a new git branch:

    ```sh
    git checkout -B ##-shortdescription
    # Example 
    git checkout -B 31-contibution-guidelines-proposal
    ```

    All branches need to follow the above convention (`##-shortdescription`) `##` 
    in this case represents the issue number that your branch is related to. Each
    issue has one and only one branch and each branch has one and only one purpose:
    to add, modify, or remove a feature/bug from the repo. `shortdescription` is 
    a few hyphon (`-`) seperated words that consisely describe the branch. This helps people 
    who may be unfamiliar with the issue number to know at a glance what the branch

* Now you're ready to write your code in your new branch! Make sure to follow
    listed [style](#rules) & [commit](#commit) guidelines/rules when contributing 
    code.

* Before you push your code to GitLab it is suggested that you run all unit tests locally.
    
    ```sh
    rails test
    ```

* Commit your changes using a descriptive commit message.

     ```sh
     git add --all
     git commit # first line is title, two newlines is description
     ```

* You will need to ask in the slack channel to be added to the GitLab repo. This
    step is necessary such that you have the necessary permissions to push up your
    branch.

* Push your branch to GitLab:

    ```sh
    git push origin ##-shortdescription
    # ex.
    git push origin 31-contibution-guidelines-proposal
    ```

* In GitLab, send a merge request to the current development branch.

* If we suggest changes to your branch then:
  * Make the required updates.
  * Re-run the unit tests to ensure tests are still passing.
  * Rebase your branch and force push to your GitLab repository (this will update
    your Merge Request):

    ```sh
    git rebase consolidation -i
    git push -f
    ```

That's it! Thank you for your contribution! :tada:

#### After your merge request is merged

After your merge request is merged, you can safely delete your branch and merge 
the changes from the main (upstream) repository:

* Delete the remote branch on GitLab either through the GitLab web UI or your 
    local shell as follows:

    ```sh
    git push origin --delete ##-shortdescription
    # ex.
    git push origin --delete 31-contibution-guidelines-proposal
    ```

* Check out the current development branch:

    ```sh
    git checkout consolidation -f
    ```

* Delete the local branch:

    ```sh
    git branch -D ##-shortdescription
    # ex. 
    git branch -D 31-contibution-guidelines-proposal
    ```

* Update your current development branch with the latest upstream version:

    ```sh
    git l --ff upstream consolidation
    ```
