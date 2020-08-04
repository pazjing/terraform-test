import requests
import bs4 as bs
import re as re
import pandas as pd

def find_word(url):
   word_list = []
   content = requests.get(url).text
   my_soup = bs.BeautifulSoup(content, 'html.parser')

   word_list = re.compile('\w+').findall(my_soup.body.text)

   print "The word occurs most on the page: "
   print (pd.Series(word_list).value_counts().sort_values(ascending=False).index[0])

#if __name__ == '__main__':
find_word('http://localhost')
