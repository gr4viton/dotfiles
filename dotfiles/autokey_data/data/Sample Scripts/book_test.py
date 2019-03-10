# import webbrowser
import clipboard

contents = clipboard.get_selection()

def open_url(url, tab=True)
    # webbrowser.get("firefox").open(url)
    browser = '/usr/bin/firefox-esr'
    opt = ['-new-tab', '-new-window'][int(not tab)
    
    dialog.list_menu(opt)
        
    args = [browser, opt, url]
    
    system.exec_command(' '.join(args))

def parse_contents(txt):
    bid_list = contents.split('\n')
    return bid_list
    
def open_avail_bag(bid, loc=True, dev=True):
    if dev:
        if loc:    
            url_base = 'http://127.0.0.3/avail_bags?bookingId='
        else:
            url_base = 'https://autobaggage.automation.kiwi.com/avail_bags?bookingId='
    
    url = '{base}{bid}'.format(base=url_base, bid=bid)
    open_url(url)
    
    
bids = parse_contents(contents)


for bid in bids:
    open_avail_bag(bid, loc=True) 
    open_avail_bag(bid, loc=False)