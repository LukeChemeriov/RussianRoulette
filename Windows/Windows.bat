rem To be clear, don't know if this works.




rem get a random number between one and six
set /a num=%random% %%7
if a == 6 (cd C:\ && echo "*boom*" && del) else (echo "*click*")
pause
