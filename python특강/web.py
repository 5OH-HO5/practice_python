import requests
from bs4 import BeautifulSoup
url = "https://finance.naver.com/sise/"

# 코스피 정보 가져오기

# 해당 URL로 요청 보내기
response = requests.get(url).text
# bs4를 이용해서 파싱
soup = BeautifulSoup(response.text, "html.parser")
# 원하는 데이터 뽑아오기
# kospi = soup.select_one('#KOSPI_now')
kospi = soup.find("span", {"id":"KOSPI_now"})
print(kospi)