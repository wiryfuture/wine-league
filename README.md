# wine-league
Dockerfile to build wine for league in a container.<br>
Tested to work with Docker and Buildah/Podman.

## Instructions
1. Build wine. You should be able to use any container image build software, but I personally use Docker and Buildah.
    - **Docker command:** ```docker build . -t wiryfuture/wine-league --build-arg WINE_TAG=tags/wine-6.16 --build-arg STAGING_TAG=tags/v6.16```
    <br>**--or--**
    - **Buildah command:** 
    ```buildah bud --build-arg WINE_TAG=tags/wine-6.16 --build-arg STAGING_TAG=tags/v6.16 --layers=true -t wiryfuture/wine-league .```
<br><br>
2. Run container images with a directory mount to export the wine build. You need all three directories: wine, out32, out64. You will need to change **/folder/for/wine** to an actual folder on your computer.
    - **Docker command:** 
    ```docker run -v /folder/for/wine:/exports wiryfuture/wine-league```
    <br>**--or--**
    - **Buildah command:** 
    ```podman run -v /folder/for/wine:/exports localhost/wiryfuture/wine-league```
<br><br>
3. To run League of Legends using this wine build; 
    - Select **out32/wine** as the wine runner in lutris for league of legends.
    <br>**--or--**
    - Run RiotClientServices directly using wine. This massive command should do it if you replace **LEAGUEPREFIX** with your actual league prefix.<br> ```WINEPREFIX=LEAGUEPREFIX WINEARCH=win32 WINEDEBUG=warn+all STAGING_SHARED_MEMORY=1 WINE_LARGE_ADDRESS_AWARE=1 ./wine "LEAGUEPREFIX/drive_c/Riot Games/Riot Client/RiotClientServices.exe"  --launch-patchline=live --launch-product=league_of_legends```

## Dev tips
- Buildah provides much larger logs of what went wrong with builds than docker does.
- Launching lutris from the console provides a much better wine log than in the lutris gui once you've enabled logs in the game's runner settings.
- You can exclude wine-staging patches by adding them as a list under the environment variable **PATCH_EXCLUDES** in the form ```"-W patchsetName -W otherpatchssetName"```
- You can use a specific branch or tag of wine and wine-staging sources using the **WINE_TAG** and **STAGING_TAG** environment variables. You pass them the same as you would the argument to ```git checkout```
- You can different git repos for wine and wine-staging using **WINE_GIT** and **STAGING_GIT**. The wine one must be of type ```git://``` and the staging one must be of type ```https://.git```
- The **THREADS** environment variable allows you to pick a specific number of threads to use for building. This defaults to all the threads on your system.
- The **BUILD64BIT** environment variable allows you to only build 32 bit wine. This is not recommended because weird stuff happens when you don't. To do so, set this to ```0```.
- If you set the **WINEDEBUG** environment variable to ```warn+all,+server``` instead of ```warn+all``` when running wine, you get **much** more detailed wine logs. This will slow down your computer.
- All patch files should be added in the **league-patches.sh** file at the bottom. This is after the wine and wine-staging repos have been downloaded, and the wine-staging patches have been applied.