#!/bin/python3

import random
import json
from urllib.request import Request, urlopen

image_save_path = '/home/kyle/.config/nitrogen/bg.png'
subreddits = ['wallpaper', 'earthporn', 'spaceporn']

reddit_url = f"https://www.reddit.com/r/{random.choice(subreddits)}/top.json?sort=top&t=month&limit=100"
headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.134 Safari/537.36'
}

def http_get(url):
    return urlopen(Request(url, headers=headers))

def is_valid_post(post):
    url = post.get('data', {}).get('url_overridden_by_dest', "")
    return bool(url) and url.lower().endswith(('.jpg', '.png', '.gif'))

response = http_get(reddit_url)

if response.status == 200:
    data = response.read().decode('utf-8')
    json_data = json.loads(data)
    posts = json_data['data']['children']
    posts_with_images = [post for post in posts if is_valid_post(post)]
    random_post = random.choice(posts_with_images)
    image_url = random_post['data']['url_overridden_by_dest']

    image_response = http_get(image_url)

    if image_response.status == 200:
        image_data = image_response.read()
        with open(image_save_path, 'wb') as image_file:
            image_file.write(image_data)
    else:
        print(f"Failed to fetch image from {image_url}")
else:
    print(f"Failed to fetch posts from {reddit_url}")

'''
kyle@x260:~$ cat .config/nitrogen/reroll.sh
#!/bin/bash

/home/kyle/.config/nitrogen/downloadRedditWallpaper.py

export DISPLAY=":0"
nitrogen --restore
'''

'''
kyle@x260:~$ cat .config/nitrogen/bg-saved.cfg
[xin_-1]
file=/home/kyle/.config/nitrogen/bg.png
mode=5
bgcolor=#000000
'''

