# Set up Custom Domain using Github Pages for static front-end project.

This guide will let you set up a custom domain quickly for your front-end project that **isn't attached to a back-end**. Use Heroku for a project with a back-end. Your project also **must use index.html**.

## Purchase Domain Name

+ Go to namecheap.com (You can use GoDaddy and others as well, but this guide will be using Namecheap.)

![purchase](https://assets.aaonline.io/fullstack/job-search/projects/js-project/gh-pages-images/purchase-domain-name.png)

+ Purchase a nice domain name for your project, and make an account. We will manage the newly purchased domain later.

## Set Up Github Pages in your Github Repo

+ In the settings menu of your project repo, scroll down to the section called Github Pages.

+ Change the Source from **none** to **master** branch or **gh-pages** branch. It's recommended to create a gh-pages branch for github hosting, but it's up to you. Master works fine too.

+ Add the custom domain link that you purchased. ex: www.coloreddiffusion.com

![github-pages2](https://assets.aaonline.io/fullstack/job-search/projects/js-project/gh-pages-images/gh-pages-source.png)


## Set Up Cloudflare (Domain Name Service)

+ Cloudflare provides a free DNS service, and very fast and quick! Can use others like Amazon Cloudfront and MaxCDN, but those require to pay. Using Cloudflare allows your project sites to load instantly through global CDNs :) It's awesome.

+ Go to https://www.cloudflare.com/, and make an account.

+ Click +Add Site at the top. Enter your purchased domain url. ex) coloreddiffusion.com. It might take 5-10 minutes for the domain to be available if you just purchased it.

![add](https://assets.aaonline.io/fullstack/job-search/projects/js-project/gh-pages-images/add-site.png)

+ After Cloudflare locates your site, manage the site's DNS records.

+ If there is a CNAME DNS type already present, delete that record.

+ Add a new record. Choose DNS type: CNAME, Name: www, and the IPv4 address is {your github username}.github.io. ex) johndoe123.github.io. github.io will be the new domain.

![cloudflare](https://assets.aaonline.io/fullstack/job-search/projects/js-project/gh-pages-images/manage-dns.png)

+ Continue, choose **Free Website**.

+ You will be given two nameservers. Mine were cass.ns.cloudflare.com and graham.ns.cloudflare.com. Yours should be similar. Save them.

## Connect Cloudflare routing to Namecheap.

+ Go back to namecheap. Click on Account on the top right, and navigate to Dashboard.

![manage](https://assets.aaonline.io/fullstack/job-search/projects/js-project/gh-pages-images/manage-domain-namecheap.png)

+ Click manage on your newly purchased site.

+ In nameservers, click custom DNS. Add the two cloudflare urls obtained. ex) cass.ns.cloudflare.com and graham.ns.cloudflare.com

![nameservers](https://assets.aaonline.io/fullstack/job-search/projects/js-project/gh-pages-images/add-cloudflare-to-namecheap.png)

## Attach CNAME to your github project.

+ Last Step!

+ In the root directory of your github repo, create a new file called CNAME

+ Inside CNAME, simply write the name of your custom domain.

![cname](https://assets.aaonline.io/fullstack/job-search/projects/js-project/gh-pages-images/CNAME-in-repo.png)

+ Add, commit and push to master or gh-pages branch (whichever is connected to github pages).

+ **Make sure you are using index.html! Everything will be loaded from index.html.**

### Done!

+ Within an hour, your site may be viewed at your new custom domain.
