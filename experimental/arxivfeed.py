import urllib
import feedparser
import time
import webbrowser

# TODOs:
# - play with formatting
# - add all relevant keywords
# - explicitly remove 

MAX_RESULTS = 500
# searches through all subjects in SUBJECTS for:
# 1) any papers by authors in AUTHORS
# 2) any papers with titles containing keywords in KEYWORDS
AUTHORS = ['Lorenzo Shaikewitz', 'Aaron Ray', 'David M. Rosen', 'Timothy D. Barfoot', 'Heng Yang', 'Luca Carlone']
SUBJECTS = ["cs.RO", "cs.LG", "math.OC", "math.ST"]
KEYWORDS = ["semidefinite", "perception", "anomaly", "aerial"]
html_file = "experimental/myarxiv.html"

url_base = "http://export.arxiv.org/api/query?search_query="
url_addition = ""

# authors
url_addition += "(au:"
for author in AUTHORS:
    url_addition += f'"{author}"'
    url_addition += "+"
url_addition = url_addition[:-1] # remove the last +
url_addition += ")"
url_addition += "+OR+"

# subjects
url_addition += "((cat:"
for subject in SUBJECTS:
    url_addition += subject
    url_addition += "+"
url_addition = url_addition[:-1] # remove the last +
url_addition += ")"
url_addition += "+AND+"

# keywords (title)
url_addition += "(ti:"
for keyword in KEYWORDS:
    url_addition += keyword
    url_addition += "+"
url_addition = url_addition[:-1] # remove the last +
url_addition += ")"
url_addition += ")"

# add sorting and 2000 queries
url_addition += "&sortBy=lastUpdatedDate&sortOrder=descending"
url_addition += "&start=0&max_results="+str(MAX_RESULTS)

url_addition_safe = urllib.parse.quote(url_addition,safe='/+:=&')
print("url:",url_base + url_addition_safe)

# Next steps:
# 1) Render query, similar to how arXiv does, in HTML
# 2) Add link to excluded papers as desired
# 3) Add to website, automatically update
# NOTE: on 10/2, latest queries were given for 9/29 (figure out if this is fundamental limitation)

# submit query
print("Submitting query...")
url = url_base + url_addition_safe
data = urllib.request.urlopen(url)
data_decoded = data.read().decode('utf-8')

d = feedparser.parse(data_decoded)
tot_results = d['feed'].opensearch_totalresults
print("Converting to HTML...")

# USEFUL CONVERSIONS
def author_to_html(author):
    author_safe = urllib.parse.quote(author,safe='/+:=&')
    html = fr"<a href=https://arxiv.org/search/?searchtype=author&query={author_safe}>"
    unbold = False
    if author in AUTHORS:
        html += "<b>"
        unbold = True
    html += author
    if unbold:
        html += "</b>"
    html += "</a>, "
    return html

def tags_to_html(entry):
    html = "Subjects: "
    html += f"<b>{entry['arxiv_primary_category']['term']}</b>"
    tags = entry['tags'][1:]
    for tag in tags:
        html += f", {tag['term']}"
    return html

def heading_to_html(entry, idx):
    html = fr"<b>[{idx+1}]</b> "
    id = entry['id'].split("/")[-1]
    link = entry['link']
    html += f"<a href={link}>{id}</a> "
    html += f"[<a href={link.replace('abs','pdf')}>pdf</a>, "
    html += f"<a href={link.replace('abs','html')}>html</a>, "
    html += f"<a href={link.replace('abs','format')}>other</a>]"
    return html

date_last = None
html_entries = []
for idx, entry in enumerate(d['entries']):
    # HERE: parse into html format
    # date if new
    date = time.strptime(entry['updated'],"%Y-%m-%dT%H:%M:%SZ")
    if date_last is None or date.tm_mday != date_last.tm_mday:
        date_html = ""
        if idx > 0:
            date_html += '<hr class="show">'
        date_html += "<h3>"
        date_html += time.strftime("%a, %d %b %Y", date)
        # date_html += f" (showing {TODO} of {TODO} entries)"
        date_html += "</h3><br>"
        html_entries.append(date_html)
        date_last = date

    # title, authors, comments, subjects, heading
    title = fr"{entry['title']}".replace('\n',"")
    authors = ""
    for author in entry["authors"]:
        author = author['name']
        authors += author_to_html(author)
    authors = authors[:-2]
    if "arxiv_entry" in entry.keys():
        comments = "Comments: "
        comments += fr"{entry['arxiv_entry']}"
    else:
        comments = None
    category = tags_to_html(entry)
    heading = heading_to_html(entry, idx)

    # convert to 
    body = f"<dt>{heading}</dt>"
    # body += "<br>"
    body += "<dd>"
    body += '<div class="list-title">' + title + "</div>"
    # body += "<br>"
    body += '<div class="list-authors">' + authors + "</div>"
    # body += "<br>"
    if comments is not None:
        body += '<div class="list-comments">' + comments + "</div>"
        # body += "<br>"
    body += '<div class="list-subjects">' + category + "</div>"
    # body += "<br>"
    body += "</dd>"

    html_entries.append(body)

prelims = """<head><link rel="stylesheet" href="arxiv.css"></head>
                <div id="content">
                <div id="content-inner">
                <div id="dlpage">
                <dl id="articles">
          """
closings = "</dl></div></div></div>"

# save to one html file
with open(html_file, "w", encoding="utf-8") as file1:
    # Writing data to a file
    file1.writelines(prelims)
    file1.writelines(html_entries)
    file1.writelines(closings)

# webbrowser.open("arxiv.html")


# Notes on arxiv API:
# - spaces in author map to '+'
# - use parentheses (=%28 and %29=) for longer queries
# 'http://export.arxiv.org/api/query?search_query=(cat:cs.RO+cs.LG+cs.SY+math.OC+math.ST)+AND+((au:"Lorenzo Shaikewitz"+"Aaron Ray")+OR+(abs:semidefinite))&sortBy=lastUpdatedDate&sortOrder=descending'
