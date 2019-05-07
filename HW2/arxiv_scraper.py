import urllib.request
import re
# import sys
import matplotlib.pyplot as plt

def scraper(author):
    # print('the input author name is', authName)
    page = 0
    publishedYear = []
    coAuthur = []
    while True:
        url = "https://arxiv.org/search/?query=" + "+".join(author.split()) + "&searchtype=author&start=" + str(page)
        content = urllib.request.urlopen(url)
        html_str = content.read().decode("utf-8")
        datePattern = "has-text-black-bis has-text-weight-semibold\">originally announced</span>[\s\S]*?</p>"
        authorPattern = "search-hit\">Authors:</span>[\s\S]*?<a href[\s\S]*?</p>"
        # authorPattern = "<a href=\"/search/?searchtype=author&query=[\s\S]*?\">[\s\S]*?</a>"
        dateResult = re.findall(datePattern, html_str)
        authorResult = re.findall(authorPattern, html_str)
        assert len(dateResult) == len(authorResult)

        # check if this page is empty
        if not dateResult:
            break
            
        for dr, ar in zip(dateResult, authorResult):
            authors = re.findall(">(.+?)</a>", ar)

            # if the author name doesn't match the exact string, skip it
            if author.lower() not in [a.lower() for a in authors]:
                continue

            # save all years
            publishedTime = dr.split("has-text-black-bis has-text-weight-semibold\">originally announced</span>")[1].split("</p>")[0].strip()
            year = "".join(re.findall("[0-9]", publishedTime.split()[1]))
            publishedYear.append(int(year))

            # save all co-authors
            for a in authors:
                coAuthur.append(a.strip())

        # for r in dateResult:
        #     publishedTime = r.split("has-text-black-bis has-text-weight-semibold\">originally announced</span>")[1].split("</p>")[0].strip()
        #     year = "".join(re.findall("[0-9]", publishedTime.split()[1]))
        #     publishedYear.append(int(year))
        
        # for r in authorResult:
        #     authors = re.findall(">(.+?)</a>", r)
        #     for a in authors:
        #         coAuthur.append(a.strip())

        # turn to the next page
        page = page + 50
    
    # print appearing times of co-authors
    authorDict = dict()
    for i in coAuthur:
        authorDict[i] = authorDict.get(i, 0) + 1
    
    # originalAuthor = " ".join(author.split("+"))
    for name in sorted(authorDict.keys()):
        if name.lower() == author.lower():
            continue
        print("[",name, "]:", authorDict[name], "times")
    
    # plot the published years
    yearDict = dict()
    for i in publishedYear:
        yearDict[i] = yearDict.get(i, 0) + 1

    pkey = []
    pvalue = []
    sorted(yearDict.items(), key = lambda kv:(kv[0], kv[1])) # sort the dict by year
    for key, value in yearDict.items():
        pkey.append(key)
        pvalue.append(value)
    plt.bar(pkey, pvalue)
    # plt.yticks(pvalue)
    if not pvalue:
        return
    plt.yticks(range(0, max(pvalue)+1))
    plt.xticks(range(min(pkey), max(pkey)+1))
    plt.show()
    

if __name__ == "__main__":
    name = input("Input Author: ")
    # name = "+".join(name.split())
    scraper(name)