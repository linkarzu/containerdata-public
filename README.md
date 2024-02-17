# Contents

<!-- toc -->

- [Youtube video to install and configure this repo](#youtube-video-to-install-and-configure-this-repo)
- [Overview](#overview)

<!-- tocstop -->

## Youtube video to install and configure this repo

<div align="center">
    <a href="https://youtu.be/25uqeRAG39A">
        <img src="https://res.cloudinary.com/daqwsgmx6/image/upload/v1708093565/youtube/docker-practical/win11-netbootxyz.png" alt="Install Windows 11 over the network with netboot.xyz and unattend.xml" width="600"/>
    </a>
</div>

## Install

```bash
git clone https://github.com/linkarzu/containerdata-public.git
```

## Important info

- Link to my blogpost with all the comments
  - `https://linkarzu.com/posts/docker-practical/windows11-netbootxyz/`
- You want to set up your macOS terminal transparent and use a window manager?
  - `https://youtube.com/playlist?list=PLZWMav2s1MZTanWwNKYvS8qgwl0HBH9J-&si=y8o3kfJg-fuAOtnT`

### Objectives

- Be able to install Windows 11 (or a lot of different OSs or tools available)
  via the network, instead of having to store them in a flash.
  We use an unattend.xml or autounattend.xml file
  - To see the list of OSs and tools available on netboot.xyz go [to this page](https://netboot.xyz/docs/faq#what-operating-systems-are-currently-available-on-netbootxyz){:target="\_blank"}
- By the end of this tutorial, you will have learned how to:
  - Install docker on Linux
  - Deploy the `netboot.xyz` and `samba` containers
  - Create winpe images
  - Install Windows 11 over the network
  - And much more

### Disclaimer

- This tutorial is designed purely for educational objectives.
- Microsoft activation keys are not included at any stage of this tutorial.
  Also, refrain from sharing any Windows activation keys in the comment section.
- You can use generic Microsoft keys to install a specific windows version
  but these keys will **not activate** Windows, you will need to provide your
  own purchased license key to activate Windows later on.
- So this guide is meant for use with a Windows activation key that you have
  legally acquired.

### Requirements

- You will need a `windows computer`, that's where we will create the WinPE
  image which will help install Windows over the network, you will understand
  what this means later
  - I will use a windows VM, that works too, as long as it can reach other
    devices in your local network
- You will need a Linux VM because that's where we will install docker
  - You can virtualize it in VirtualBox (or whatever you chose), I havent'
    tested this in virtualization software, but it should work
  - If you run a hypervisor already (Proxmox, XCP-ng, VMware) just run the VM
    there

### Help out devs

- If you like the netboot.xyz project, please donate to their devs, if possible
  at least one time
  - `https://github.com/sponsors/netbootxyz`
  - I don't know the developers, nor had I had any contact with them

### Alternatives

- If you don't want to boot over network, there's Ventoy, that allows you to
  store multile ISOs in a flash drive and boot from those
- `https://github.com/ventoy/Ventoy`
- That's not the purpose of this guide, this is specifically to avoid USB
  drives, and boot from the network instead

### Credits

- This guide was built on Techno Tim's YouTube video, I didn't know about
  netboot.xyz before this
  - `https://youtu.be/4btW5x_clpg?si=G7_bLA6axCvOIx53`
- I was having issues with the Windows installation part, but with a comment
  from user @jaromirrivera on Techno Tim's blogpost I was able to figure it out
  and go from there
  - `https://technotim.live/posts/netbootxyz-tutorial/`
- Yeah, my blog looks like Techno Tim's, guess how I set it up :shhhhh:
