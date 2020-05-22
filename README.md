<!-- 
@AUTHOR: imyme6yo "imyme6yo@gmail.com"
@DRAFT: 20200317
@UPDATE: 20200405
-->



### Git Installation

> alpine
> '''shell
> apk add --no-cache git 
> '''
> linux
> apt-get install -y git
> centOS
> yum install git

### TODO
    # merge startup & project shell script

### Branch List

    # 20200405 express @express
    # 20200405 falcon @falcon
    # 20200405 python3 @python3
    # 20200405 python3 @python
    # 20200405 svelte + sapper @svelte-sapper
    # 20200405 svelte @svelte
    # 20200405 vue2 @vue2
    # 20200405 react @react
    # 20200326 svelte @svelte
    # 20200326 svelte + sapper @svelte-sapper
    # 20200325 nuxt @nuxt - Not complete, it need to compltet shell script with expect.
    # 20200320 python3 @python3
    # 20200320 python3 @python
    # 20200318 react @react
    # 20200317 vue2 @vue2

### Trouble Shoots

#### When docker pull image, connection refuged
reference: [[docker] pulling 이 안될경우](https://m.blog.naver.com/PostView.nhn?blogId=varkiry05&logNo=221450373568&proxyReferer=https:%2F%2Fwww.google.com%2F)

error message:

'''
    ERROR: Get https://registry-1.docker.io/v2/: dial tcp: lookup registry-1.docker.io on [::1]:53: read udp [::1]:40562->[::1]:53: read: connection refused
'''

# 