const https = require('https');
const fs = require('fs');
const path = require('path');
const url = require('url');

const randArrItem = (arr) => arr[Math.floor(Math.random() * arr.length)];

const subreddits = ['wallpaper', 'earthporn', 'spaceporn'];

const redditUrl = `https://www.reddit.com/r/${randArrItem(subreddits)}/top.json?sort=top&t=month&limit=100`;
const parsedRedditUrl = url.parse(redditUrl);
const getOptions = {
  host: parsedRedditUrl.host,
  path: parsedRedditUrl.path,
  headers: {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.134 Safari/537.36'
  }
};

const isValidPost = (post) => {
    const url = post?.data?.url_overridden_by_dest ?? "";
    return /\.(jpg|png|gif)$/i.test(url);
};

https.get(getOptions, (res) => {
  let data = '';
  res.on('data', (chunk) => {
    data += chunk;
  });
  res.on('end', () => {
    const json = JSON.parse(data);
    const posts = json.data.children;
    const postsWithImages = posts.filter(isValidPost);
    const randomPost = randArrItem(postsWithImages);
    const imageUrl = randomPost.data.url_overridden_by_dest;

    const imagePath = '/home/kyle/.config/nitrogen/bg.png';

    https.get(imageUrl, (res) => {
      res.pipe(fs.createWriteStream(imagePath));
      // console.log(`Image saved to ${imagePath}`);
    });
  });
}).on('error', (err) => {
  console.error(err);
});

/*
#!/bin/bash

/usr/local/bin/node /home/kyle/.config/nitrogen/downloadRedditWallpaper.js

export DISPLAY=":0"
nitrogen --restore
*/

/*
kyle@x260:~$ cat .config/nitrogen/bg-saved.cfg
[xin_-1]
file=/home/kyle/.config/nitrogen/bg.png
mode=5
bgcolor=#000000
*/
