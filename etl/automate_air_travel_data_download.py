"""
Air Travel Data Warehouse – Data Extraction Script
--------------------------------------------------
This script automates the download of monthly air travel datasets from the
U.S. Bureau of Transportation Statistics (BTS) website.

Usage:
    python download_air_travel_data.py

Requirements:
    - Python 3.10+
    - requests, beautifulsoup4, selenium
    - ChromeDriver installed and accessible in PATH

Author: Mohamed Hassan
Date: November 2025
Layer: Bronze (Data Ingestion)
"""


from bs4 import BeautifulSoup
import requests
import time
import os
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from datetime import datetime

# -----------------------------
# CONFIGURATION
# -----------------------------
DOWNLOAD_DIR = r"C:\Users\stgadmin\Project\air-travel-dwh\Data"  # <-- Change this to your target folder
START_YEAR = 2025
START_MONTH = 1

# -----------------------------
# HELPER FUNCTIONS
# -----------------------------
def month_name_to_number(month_name):
    months = {
        'January': 1, 'February': 2, 'March': 3, 'April': 4,
        'May': 5, 'June': 6, 'July': 7, 'August': 8,
        'September': 9, 'October': 10, 'November': 11, 'December': 12
    }
    return months.get(month_name.title())

def get_latest_available_period():
    """Scrape the BTS site and return (month_number, year_number)."""
    url = "https://www.transtats.bts.gov/DL_SelectFields.aspx?gnoyr_VQ=FMG&QO_fu146_anzr=Nv4+Pn44vr4"
    response = requests.get(url)
    response.raise_for_status()
    soup = BeautifulSoup(response.text, 'html.parser')

    span_element = soup.find('span', id='lblLatest')
    if not span_element:
        raise ValueError("Could not find latest month info on the webpage")

    date_text = span_element.get_text().split(':')[-1].strip()
    month_name, year_str = date_text.split()
    month_num = month_name_to_number(month_name)
    year_num = int(year_str)
    return month_num, year_num

def generate_month_year_pairs(start_year, start_month, end_year, end_month):
    """Generate all (month, year) pairs between two dates inclusive."""
    pairs = []
    current = datetime(start_year, start_month, 1)
    end = datetime(end_year, end_month, 1)
    while current <= end:
        pairs.append((current.month, current.year))
        if current.month == 12:
            current = datetime(current.year + 1, 1, 1)
        else:
            current = datetime(current.year, current.month + 1, 1)
    return pairs

def is_file_downloaded(month, year):
    """Check if a file for this period already exists locally."""
    expected_filename = f"{year}_{month:02d}.csv"  # Adjust if your files have a different naming pattern
    return os.path.exists(os.path.join(DOWNLOAD_DIR, expected_filename))

def download_file(month, year, driver):
    """Trigger a download using Selenium."""
    driver.get("https://www.transtats.bts.gov/DL_SelectFields.aspx?gnoyr_VQ=FMG&QO_fu146_anzr=Nv4+Pn44vr4")
    driver.implicitly_wait(5)

    select_period = Select(driver.find_element(By.NAME, "cboPeriod"))
    select_year = Select(driver.find_element(By.NAME, "cboYear"))

    select_period.select_by_value(str(month))
    select_year.select_by_value(str(year))

    driver.find_element(By.ID, "chkAllVars").click()
    driver.find_element(By.ID, "btnDownload").click()

    print(f"Downloading {year}-{month:02d}...")
    time.sleep(60)  # Wait for the download to complete (adjust if needed)

# -----------------------------
# MAIN LOGIC
# -----------------------------
if __name__ == "__main__":
    latest_month, latest_year = get_latest_available_period()
    print(f"Latest available: {latest_month}/{latest_year}")

    os.makedirs(DOWNLOAD_DIR, exist_ok=True)

    all_periods = generate_month_year_pairs(START_YEAR, START_MONTH, latest_year, latest_month)

    chrome_options = Options()
    chrome_options.add_experimental_option("prefs", {
        "download.default_directory": DOWNLOAD_DIR,
        "download.prompt_for_download": False,
        "safebrowsing.enabled": True
    })

    service = Service()
    driver = webdriver.Chrome(service=service, options=chrome_options)

    for month, year in all_periods:
        if not is_file_downloaded(month, year):
            #dl_dir = DOWNLOAD_DIR + '/'+str(year)+'/'+str(month)
            #os.makedirs(dl_dir, exist_ok=True)
            chrome_options = Options()
            chrome_options.add_experimental_option("prefs", {
                "download.default_directory": DOWNLOAD_DIR,
                "download.prompt_for_download": False,
                "safebrowsing.enabled": True
            })

            service = Service()
            driver = webdriver.Chrome(service=service, options=chrome_options)
            download_file(month, year, driver)
        else:
            print(f"Skipping {year}-{month:02d}, already downloaded.")

    driver.quit()
    print("All files up to date ✅")
