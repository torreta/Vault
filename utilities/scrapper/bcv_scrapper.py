from datetime import datetime
from requests_html import HTMLSession
import urllib3


def scrapeData():
    # Suppresses SSL errors
    urllib3.disable_warnings()
    session = HTMLSession()

    baseURL = "http://www.bcv.org.ve/"

    r = session.get(baseURL, verify=False)

    usd = r.html.xpath(
        '//*[@id="dolar"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong/text()'
    )
    euro = r.html.xpath(
        '//*[@id="euro"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong/text()'
    )
    yuan = r.html.xpath(
        '//*[@id="yuan"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong/text()'
    )
    lira = r.html.xpath(
        '//*[@id="lira"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong/text()'
    )
    rublo = r.html.xpath(
        '//*[@id="rublo"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong/text()'
    )
    valid_date = r.html.xpath(
        "/html/body/div[4]/div/div[2]/div/div[1]/div[1]/section[1]/div/div[2]/div/div[8]/span/text()"
    )
    current_date = datetime.now()

    exchange_rate = {
        "usd": float(usd[0].replace(",", ".")),
        "euro": float(euro[0].replace(",", ".")),
        "yuan": float(yuan[0].replace(",", ".")),
        "lira": float(lira[0].replace(",", ".")),
        "rublo": float(rublo[0].replace(",", ".")),
        "scrap_date": current_date.isoformat(sep=" ", timespec="hours"),
        "valid_date": valid_date[0].split(","),
    }

    return exchange_rate