#!/bin/python
#author: bluescreenofjeff

#For more information:
#GITHUB
#BLOGPOST

import os,argparse,ntpath,random,string,re,subprocess #native

randomize_settings = {}
processdetails = {}

#Built-in lists

#customcharset
randomize_settings['customcharset'] = ''

#useragents
randomize_settings['useragents'] = ['Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0)','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; Media Center PC 6.0)','Mozilla/5.0 (Windows NT 10.0; WOW64)','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36','Mozilla/5.0 (Windows NT 6.0; rv:34.0) Gecko/20100101 Firefox/34.0','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36','Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:5.0) Gecko/20100101 Firefox/5.0','Mozilla/5.0 (Windows NT 6.1; rv:1.9) Gecko/20100101 Firefox/4.0','Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Firefox/31.0','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2966.0 Safari/537.36','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Firefox/28.0','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Firefox/31.0','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 GTB6 (.NET CLR 3.5.30729)','Mozilla/5.0 (compatible, MSIE 11, Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko','Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0)','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1)','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/6.0)']

#spawnto
randomize_settings['spawnto'] = {'%windir%\\\\syswow64\\\\eventvwr.exe' : '%windir%\\\\sysnative\\\\eventvwr.exe', '%windir%\\\\syswow64\\\\taskeng.exe' : '%windir%\\\\sysnative\\\\taskeng.exe', '%windir%\\\\syswow64\\\\spoolsv.exe' : '%windir%\\\\sysnative\\\\spoolsv.exe', '%windir%\\\\syswow64\\\\dllhost.exe' : '%windir%\\\\sysnative\\\\dllhost.exe', '%windir%\\\\syswow64\\\\gpupdate.exe' : '%windir%\\\\sysnative\\\\gpupdate.exe'}

#pipename
randomize_settings['pipename'] = ['lsarpc_##','samr_##','netlogon_##','wkssvc_##','srvsvc_##','mojo_##']

#pipename_stager
randomize_settings['pipename_stager'] = ['browser_##','comnode_##','spoolss_##','llsrpc_##','comnap_##']

#dns_stager_subhost
randomize_settings['dns_stager_subhost'] = ['.m.123456.','.ftp.123456.','.imap.123456.','.pop.123456.','.smtp.123456.','.mail.123456.','.webmail.123456.','.blog.123456.','.wiki.123456.','.support.123456.','.kb.123456.','.help.123456.','.go.123456.','.static.123456.','.api.123456.','.dev.123456.','.events.123456.','.feeds.123456.','.forums.123456.','.groups.123456.','.img.123456.','.media.123456.','.news.123456.','.sites.123456.','.admin.123456.','.mysql.123456.','.store.123456.','.vpn.123456.','.admin.123456.','.beta.123456.','.photos.123456.','.files.123456.','.resources.123456.','.secure.123456.','.ssl.123456.','.apps.123456.','.pic.123456.','.status.123456.','.mobile.123456.','.search.123456.','.live.123456.','.videos.123456.','.lists.123456.']

#dns_stager_prepend
randomize_settings['dns_stager_prepend'] = ['v=spf1 a:mail.google.com -all','google-site-verification=','microsoft-site-verification=','amazon-site-verification=']

#wordlist
randomize_settings['wordlist'] = ['time','person','year','way','day','thing','man','world','life','hand','part','child','eye','woman','place','work','week','case','point','government','company','number','group','problem','fact']


#Setting Defaults
randomize_settings['count'] = 1
randomize_settings['cobalt'] = os.getcwd()
randomize_settings['notest'] = False
randomize_settings['launchdir'] = os.getcwd()

#process detail counts
processdetails['errorcount'] = 1

def chargen(charset,number):
	number = int(number)
	if charset == 'alphanumeric':
		return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(number))
	elif charset == 'alphanumspecial':
		return ''.join(random.choice(string.ascii_letters + string.digits + string.punctuation) for _ in range(number))
	elif charset == 'alphanumspecialurl':
		return ''.join(random.choice(string.ascii_letters + string.digits + '-._~') for _ in range(number))
	elif charset == 'alpha':
		return ''.join(random.choice(string.ascii_letters) for _ in range(number))
	elif charset == 'alphaupper':
		return ''.join(random.choice(string.ascii_uppercase) for _ in range(number))
	elif charset == 'alphalower':
		return ''.join(random.choice(string.ascii_lowercase) for _ in range(number))
	elif charset == 'alphauppernumber':
		return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(number))
	elif charset == 'alphalowernumber':
		return ''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(number))
	elif charset == 'number':
		return ''.join(random.choice(string.digits) for _ in range(number))
	elif charset == 'hex':
		return ''.join(random.choice(string.hexdigits) for _ in range(number))
	elif charset == 'netbios':
		return ''.join(random.choice(string.ascii_letters + string.digits + "!@#$%^&)(.-'_{}~") for _ in range(number))
	elif charset == 'customchar':
		return ''.join(random.choice(randomize_settings['customcharset']) for _ in range(number))
	elif charset == 'word':
		return ''.join(random.choice(randomize_settings['wordlist']) for _ in range(number))	
	elif charset == 'boolean':
		return ''.join(random.choice(['True', 'False']) for _ in range(number))	
	else:
		pass

#PROCESS FUNCTION
def processprofile(profile):
	randomize_settings['tempfilename'] = randomize_settings['output'] + '__' + chargen('alphanumeric',8) + '.profile.tmp'			

	filewrite('',randomize_settings['tempfilename'],'w')

	with open(profile) as profilefile:
		profilecontent = profilefile.read().splitlines()

	spawnto_x86 = random.choice(randomize_settings['spawnto'].keys())
	spawnto_x64 = randomize_settings['spawnto'][spawnto_x86]

	for line in profilecontent:
		m = re.findall('%%(alphanumeric|alphanumspecial|alphanumspecialurl|alphaupper|alphalower|alphauppernumber|alphalowernumber|alpha|number|hex|netbios|customchar|useragent|spawnto_x86|spawnto_x64|pipename|pipename_stager|dns_stager_subhost|dns_stager_prepend|word|boolean)\:?(\d*)%%', line)
		if m:
			for eachmatch in m:
				replacetype = eachmatch[0]
				replacevalue = eachmatch[1]

				#characters
				if replacetype in ['alphanumeric','alphanumspecial','alphanumspecialurl','alphaupper','alphalower','alphauppernumber','alphalowernumber','alpha','number','hex','netbios','customchar','word','boolean']:
					if replacetype == 'customchar' and randomize_settings['customcharset'] == '':
						print '[!] Error - "customchar" variable called with no customchar file specified:'
						print '	' + line
						os._exit(0)
					if replacevalue == '' or replacevalue == None:
						line = line.replace('%%' + str(replacetype) + '%%',str(chargen(replacetype,1)),1)
					else:
						line = line.replace('%%' + str(replacetype) + ':' + str(replacevalue) + '%%',str(chargen(replacetype,replacevalue)),1)

				elif replacetype == 'useragent':
					line = line.replace('%%useragent%%',random.choice(randomize_settings['useragents']),1)

				elif replacetype == 'spawnto_x86':
					line = line.replace('%%spawnto_x86%%',spawnto_x86,1)
				
				elif replacetype == 'spawnto_x64':
					line = line.replace('%%spawnto_x64%%',spawnto_x64,1)

				elif replacetype == 'pipename':
					line = line.replace('%%pipename%%',random.choice(randomize_settings['pipename']),1)

				elif replacetype == 'pipename_stager':
					line = line.replace('%%pipename_stager%%',random.choice(randomize_settings['pipename_stager']),1)
				
				elif replacetype == 'dns_stager_subhost':
					line = line.replace('%%dns_stager_subhost%%',random.choice(randomize_settings['dns_stager_subhost']),1)
				
				elif replacetype == 'dns_stager_prepend':
					line = line.replace('%%dns_stager_prepend%%',random.choice(randomize_settings['dns_stager_prepend']),1)				

		filewrite(line + '\n',randomize_settings['tempfilename'],'a')

	#c2lint testing
	if randomize_settings['notest']:
		os.system('mv ' + randomize_settings['tempfilename'] + ' ' + randomize_settings['tempfilename'].replace('.tmp','',-1))
		print '[+] Profile written to: ' + randomize_settings['tempfilename'].replace('.tmp','',-1)
	elif c2lint():
		os.system('mv ' + randomize_settings['tempfilename'] + ' ' + randomize_settings['tempfilename'].replace('.tmp','',-1))
		print '[+] Profile written to: ' + randomize_settings['tempfilename'].replace('.tmp','',-1)

def c2lint():
	testingoutput = os.popen('cd ' + randomize_settings['cobalt'] + ' && ' + randomize_settings['cobalt'] + 'c2lint ' + randomize_settings['tempfilename']).readlines()
	fail = False
	for outputline in testingoutput:
		if 'Error(s)' in outputline or '[-]' in outputline:
			fail = True
		if fail and processdetails['errorcount'] < 4:
			print '	[-] Error with c2lint check - Attempt ' + str(processdetails['errorcount']) + ' of 3'
			processdetails['errorcount'] += 1
			c2lint()
		elif fail and processdetails['errorcount'] > 3:
			for _ in testingoutput:
				print _
			print '[!] The profile failed c2lint error checking three times. Review the c2lint error report above and modify the profile. Exiting.'
			os.system('rm ' + randomize_settings['tempfilename'])
			os._exit(0)
	processdetails['errorcount'] = 1
	return True

def filewrite(texttowrite,filetowriteto,mode):
	f = open(filetowriteto, mode)
	f.write(texttowrite)
	f.close()

if __name__ == '__main__':

	parser = argparse.ArgumentParser(description='''malleable-c2-randomizer.py''')
	parser.add_argument('-profile','-p', help='Path to the Malleable C2 template to randomize', required=True)
	parser.add_argument('-count','-c', help='The number of randomized profiles to create {Default = 1}')
	parser.add_argument('-cobalt','-d',  help='The directory where Cobalt Strike is located (for c2lint) {Default = current directory}')
	parser.add_argument('-output','-o', help='Output base name {Default = template basename and random string}')
	parser.add_argument('-notest','-n', help='Skip testing with c2lint', action='store_true')

	parser.add_argument('-charset', help='File with a custom characterset to use with the %%customchar%% variable {Default = Built-in list}')
	parser.add_argument('-wordlist', help='File with a list of custom words to use with the %%word%% variable {Default = Built-in list}')
	parser.add_argument('-useragent', help='File with a list of useragents {Default = Built-in list}')
	parser.add_argument('-spawnto', help='File with a list of custom spawnto processes {Default = Built-in list}')
	parser.add_argument('-pipename', help='File with a list of custom pipename values {Default = Built-in list}')
	parser.add_argument('-pipename_stager', help='File with a list of custom pipename_stager values {Default = Built-in list}')
	parser.add_argument('-dns_stager_subhost', help='File with a list of custom dns_stager_subhost values {Default = Built-in list}')
	parser.add_argument('-dns_stager_prepend', help='File with a list of custom dns_stager_prepend values {Default = Built-in list}')
	
	args = parser.parse_args()
	
	if os.path.isfile(args.profile):
		randomize_settings['profile'] = args.profile
	else:
		parser.error('please specify a valid Malleable C2 profile')

	if args.count != None:
		try:
			if int(args.count) > 0:
				randomize_settings['count'] = int(args.count)
			else:
				parser.error('count must be a positive number')
		except:
			parser.error('count must be a positive number')

	if args.cobalt:
		if not args.cobalt.endswith('/'):
			args.cobalt = args.cobalt + '/'
		if os.path.isdir(args.cobalt) and os.path.isfile(args.cobalt + 'c2lint'):
			randomize_settings['cobalt'] = args.cobalt
		else:
			parser.error('c2lint not present in current working directory or specified Cobalt Strike directory. Provide a valid Cobalt Strike directory or use the "-notest" flag')
	elif not args.cobalt and not os.path.isfile(randomize_settings['cobalt'] + 'c2lint') and not args.notest:
		parser.error('c2lint not present in current working directory or specified Cobalt Strike directory. Provide a valid Cobalt Strike directory or use the "-notest" flag')

	if args.output:
		if os.path.isabs(args.output):
			randomize_settings['output'] = args.output
		else:
			randomize_settings['output'] = randomize_settings['launchdir'] + '/' + args.output

	else:
		if ntpath.basename(args.profile).endswith('.profile'):
			randomize_settings['output'] = randomize_settings['launchdir'] + '/' + ntpath.basename(args.profile).replace('.profile','',-1)
		else:
			randomize_settings['output'] = randomize_settings['launchdir'] + '/' + ntpath.basename(args.profile)

	if args.notest:
		randomize_settings['notest'] = True

	if args.charset:
		if os.path.isfile(args.charset):
			with open(args.charset) as charsetfile:
				randomize_settings['customcharset'] = ''.join(set(charsetfile.read().replace('\n','').replace('\r','')))

		else:
			parser.error('the custom charset file specified does not exist')

	if args.wordlist:
		if os.path.isfile(args.wordlist):
			with open(args.wordlist) as wordlistfile:
				randomize_settings['wordlist'] = list(set(wordlistfile.read().splitlines()))
		else:
			parser.error('the custom wordlist file specified does not exist')

	if args.useragent:
		if os.path.isfile(args.useragent):
			with open(args.useragent) as useragentfile:
				randomize_settings['useragents'] = list(set(useragentfile.read().splitlines()))
		else:
			parser.error('the custom useragent list file specified does not exist')

	if args.spawnto:
		if os.path.isfile(args.spawnto):
			randomize_settings['spawnto'] = {}
			with open(args.spawnto) as spawntofile:
				lines = spawntofile.read().splitlines()
				for each in lines:
					if not each.startswith('#'):
						randomize_settings['spawnto'][each.split("\t")[0]] = each.split("\t")[1]
		else:
			parser.error('the custom spawnto list file specified does not exist')

	if args.pipename:
		if os.path.isfile(args.pipename):
			with open(args.pipename) as pipenamefile:
				randomize_settings['pipename'] = list(set(pipenamefile.read().splitlines()))
		else:
			parser.error('the custom pipename list file specified does not exist')

	if args.pipename_stager:
		if os.path.isfile(args.pipename_stager):
			with open(args.pipename_stager) as pipenamestagerfile:
				randomize_settings['pipename_stager'] = list(set(pipenamestagerfile.read().splitlines()))
		else:
			parser.error('the custom pipename_stager list file specified does not exist')

	if args.dns_stager_subhost:
		if os.path.isfile(args.dns_stager_subhost):
			with open(args.dns_stager_subhost) as dnsstagerfile:
				randomize_settings['dns_stager_subhost'] = list(set(dnsstagerfile.read().splitlines()))
		else:
			parser.error('the custom dns_stager_subhost list file specified does not exist')
	
	if args.dns_stager_prepend:
		if os.path.isfile(args.dns_stager_prepend):
			with open(args.dns_stager_prepend) as dnsprependfile:
				randomize_settings['dns_stager_prepend'] = list(set(dnsprependfile.read().splitlines()))
		else:
			parser.error('the custom dns_stager_prepend list file specified does not exist')

	for iter in range(int(randomize_settings['count'])):
		iter += 1
		print '[*] Generating profile ' + str(iter) + ' of ' + str(randomize_settings['count'])
		processprofile(randomize_settings['profile'])
	print '[+] Profile randomization complete!'
