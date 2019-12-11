import requests
from bs4 import BeautifulSoup
url = "http://www.naver.com"

response = requests.get(url).text
soup = BeautifulSoup(response, "html.parser")

# 네이버 실시간 인기검색어 20개
for i in range(1, 21):
    time = soup.select_one(f"#PM_ID_ct > div.header > div.section_navbar > div.area_hotkeyword.PM_CL_realtimeKeyword_base > div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > ul > li:nth-child({i}) > a > span.ah_k")
    print(time.text)


soup.select(time)