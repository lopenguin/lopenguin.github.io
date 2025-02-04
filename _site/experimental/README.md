# Custom arXiv Feed
As a scientist, it is important to stay up to date on new work, and there is no better repository than arXiv. The main problem is that current arXiv categories are a bit too broad: I work in robotics, but not haptics or human-robot interaction. These are interesting fields but I don't need daily updates.

My solution: query the arXiv API! Here's how to use my script and set up your own query.

## Set your topics of interest
In `arxivfeed.py` set authors, subjects, and keywords that are interesting to you. The feed will contain *all* papers by specified authors, and any papers within the subjects with abstracts that match your keywords.

## Set up for github pages
The `arxivfeed.py` script saves everything to the file specified in `html_file`. I added a GitHub action (in `.github/workflows`) to automatically run the script and push the html to my repository. Here is the workflow:

```yml
name: arxiv

on: 
  workflow_dispatch:
  schedule:
    - cron: "30 9 * * *"    #runs at 9:30 UTC everyday

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: checkout repo content
        uses: actions/checkout@v4 # checkout the repository content to github runner.
      - name: setup python
        uses: actions/setup-python@v5
        with:
          python-version: 3.9 #install the python needed
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install feedparser
      - name: execute py script
        run: |
          python experimental/arxivfeed.py
      - name: commit files
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add -A
          git diff-index --quiet HEAD || (git commit -a -m "updated arxiv" --allow-empty)
          
      - name: push changes
        uses: ad-m/github-push-action@master
        with:
          github_token: ${{ secrets.ACCESS_TOKEN }}
          branch: master 
```

What's happening is relatively self-explanatory. First, I set it to run at 6:30 AM every day using UTC. Then, I set up the job. The job runs on ubuntu (latest) and does the following steps:
1. Checkout the repo
2. Make sure python is installed
3. Make sure dependencies (feedparser) are installed
4. Run the script
5. Commit the changes
6. Push the changes

The only step that requires anything more is pushing the changes. To do this, you need to set up a GitHub secret. You can find secrets in the settings tab of the repository. Add a secret for actions called "ACCESS_TOKEN" and paste in a personal access token for your github (you probably should only give it write access to this repo).

That's it! If you want to test the script go to the actions tab, click on arxiv, and hit "run workflow".