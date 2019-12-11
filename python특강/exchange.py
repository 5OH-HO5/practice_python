import requests
from bs4 import BeautifulSoup
url = "https://finance.naver.com/marketindex/"

response = requests.get(url).text
soup = BeautifulSoup(response, "html.parser")
# select_one (원래는 css에서 사용)
exchange = soup.select_one("#exchangeList > li.on > a.head.usd > div > span.value")

print(exchange.text)