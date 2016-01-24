--KristAPI Alpha
local version = "0.63"
if not http then
  printError("KristAPI " .. version .. " requires the HTTP API to be enabled!")
  failedLoad = true
  return
end
function getVersion()
  return version
end
local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end
base = trim(http.get("https://raw.githubusercontent.com/BTCTaras/kristwallet/master/staticapi/syncNode").readAll())
--SHA256, needed for other processes
local a=2^32;local b=a-1;local function c(d)local mt={}local e=setmetatable({},mt)function mt:__index(f)local g=d(f)e[f]=g;return g end;return e end;local function h(e,i)local function j(k,l)local m,o=0,1;while k~=0 and l~=0 do local p,q=k%i,l%i;m=m+e[p][q]*o;k=(k-p)/i;l=(l-q)/i;o=o*i end;m=m+(k+l)*o;return m end;return j end;local function r(e)local s=h(e,2^1)local t=c(function(k)return c(function(l)return s(k,l)end)end)return h(t,2^e.n or 1)end;local u=r({[0]={[0]=0,[1]=1},[1]={[0]=1,[1]=0},n=4})local function v(k,l,w,...)local x=nil;if l then k=k%a;l=l%a;x=u(k,l)if w then x=v(x,w,...)end;return x elseif k then return k%a else return 0 end end;local function y(k,l,w,...)local x;if l then k=k%a;l=l%a;x=(k+l-u(k,l))/2;if w then x=bit32_band(x,w,...)end;return x elseif k then return k%a else return b end end;local function z(A)return(-1-A)%a end;local function B(k,C)if C<0 then return lshift(k,-C)end;return math.floor(k%2^32/2^C)end;local function D(A,C)if C>31 or C<-31 then return 0 end;return B(A%a,C)end;local function lshift(k,C)if C<0 then return D(k,-C)end;return k*2^C%2^32 end;local function E(A,C)A=A%a;C=C%32;local F=y(A,2^C-1)return D(A,C)+lshift(F,32-C)end;local f={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function G(H)return string.gsub(H,".",function(w)return string.format("%02x",string.byte(w))end)end;local function I(J,n)local H=""for K=1,n do local L=J%256;H=string.char(L)..H;J=(J-L)/256 end;return H end;local function M(H,K)local n=0;for K=K,K+3 do n=n*256+string.byte(H,K)end;return n end;local function N(O,P)local Q=64-(P+9)%64;P=I(8*P,8)O=O.."\128"..string.rep("\0",Q)..P;assert(#O%64==0)return O end;local function R(S)S[1]=0x6a09e667;S[2]=0xbb67ae85;S[3]=0x3c6ef372;S[4]=0xa54ff53a;S[5]=0x510e527f;S[6]=0x9b05688c;S[7]=0x1f83d9ab;S[8]=0x5be0cd19;return S end;local function T(O,K,S)local U={}for V=1,16 do U[V]=M(O,K+(V-1)*4)end;for V=17,64 do local g=U[V-15]local W=v(E(g,7),E(g,18),D(g,3))g=U[V-2]U[V]=U[V-16]+W+U[V-7]+v(E(g,17),E(g,19),D(g,10))end;local k,l,w,X,Y,d,Z,_=S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[8]for K=1,64 do local W=v(E(k,2),E(k,13),E(k,22))local a0=v(y(k,l),y(k,w),y(l,w))local a1=W+a0;local a2=v(E(Y,6),E(Y,11),E(Y,25))local a3=v(y(Y,d),y(z(Y),Z))local a4=_+a2+a3+f[K]+U[K]_,Z,d,Y,X,w,l,k=Z,d,Y,X+a4,w,l,k,a4+a1 end;S[1]=y(S[1]+k)S[2]=y(S[2]+l)S[3]=y(S[3]+w)S[4]=y(S[4]+X)S[5]=y(S[5]+Y)S[6]=y(S[6]+d)S[7]=y(S[7]+Z)S[8]=y(S[8]+_)end;local function sha256(O)O=N(O,#O)local S=R({})for K=1,#O,64 do T(O,K,S)end;return G(I(S[1],4)..I(S[2],4)..I(S[3],4)..I(S[4],4)..I(S[5],4)..I(S[6],4)..I(S[7],4)..I(S[8],4))end
--Making V2 address. Intended for wallets.
local function tobase36(j)
  if j <= 6 then return "0"
  elseif j <= 13 then return "1"
  elseif j <= 20 then return "2"
  elseif j <= 27 then return "3"
  elseif j <= 34 then return "4"
  elseif j <= 41 then return "5"
  elseif j <= 48 then return "6"
  elseif j <= 55 then return "7"
  elseif j <= 62 then return "8"
  elseif j <= 69 then return "9"
  elseif j <= 76 then return "a"
  elseif j <= 83 then return "b"
  elseif j <= 90 then return "c"
  elseif j <= 97 then return "d"
  elseif j <= 104 then return "e"
  elseif j <= 111 then return "f"
  elseif j <= 118 then return "g"
  elseif j <= 125 then return "h"
  elseif j <= 132 then return "i"
  elseif j <= 139 then return "j"
  elseif j <= 146 then return "k"
  elseif j <= 153 then return "l"
  elseif j <= 160 then return "m"
  elseif j <= 167 then return "n"
  elseif j <= 174 then return "o"
  elseif j <= 181 then return "p"
  elseif j <= 188 then return "q"
  elseif j <= 195 then return "r"
  elseif j <= 202 then return "s"
  elseif j <= 209 then return "t"
  elseif j <= 216 then return "u"
  elseif j <= 223 then return "v"
  elseif j <= 230 then return "w"
  elseif j <= 237 then return "x"
  elseif j <= 244 then return "y"
  elseif j <= 251 then return "z"
  else return "e" --e is most commonly sought for vanity addresses
  end
end
function makev2address(key)
  local protein = {}
  local stick = sha256(sha256(key))
  local n = 0
  local link = 0
  local v2 = "k"
  repeat
    if n < 9 then protein[n] = string.sub(stick,0,2)
    stick = sha256(sha256(stick)) end
    n = n + 1
  until n == 9
  n = 0
  repeat
    link = tonumber(string.sub(stick,1+(2*n),2+(2*n)),16) % 9
    if string.len(protein[link]) ~= 0 then
      v2 = v2 .. tobase36(tonumber(protein[link],16))
      protein[link] = ''
      n = n + 1
    else
      stick = sha256(stick)
    end
  until n == 9
  return v2
end
--used for some other functions
local function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end
--Create address with password.
function createaddress(password)
  return makev2address(sha256("KRISTWALLET" .. password) .. "-000")
end
--Create an outdated V1 address with password.
function createv1address(password)
  local txt = sha256("KRISTWALLET" .. password) .. "-000"
  return txt:sub(0, 10)
end
--Create a double vault. Returns the key and password of the vault (password is for use in all other functions, for give() set the fourth parameter to true)
function createvault(password1, password2) --password1 = vault password, password2 = your password
  masterkey = sha256("KRISTWALLET" .. password2) .. "-000"
  pass = sha256(masterkey .. "-"..sha256(password1))
  address = makev2address(pass)
  return address, pass
end
--There is no local vault function, as it is literally just a sha256 hash stored as a file.
--Allows any amount of passwords in a vault; the last is always your password. Returns the same as above, same syntax as above.
--NOTE: Encodes differently than createvault(), they are not interchangeable!
function createcustomvault(...)
  local tArgs = {...}
  local yp = tArgs[#tArgs]
  local args = {}
  for i = 1, #tArgs-1 do
    args[i] = tArgs[i]
  end
  tArgs = args
  masterkey = sha256("KRISTWALLET" .. yp) .. "-000"
  str = ""
  for i = 1, #tArgs do
    str = str .. sha256(tArgs[i])
  end
  pass = sha256(masterkey .. "-" .. sha256(str))
  address = makev2address(pass)
  return address, pass
end
--Create an outdated V1 address from a raw string (used for first few days of Krist).
function createrawaddress(password)
  local txt = sha256(password)
  return txt:sub(0, 10);
end
--Returns all .kst domains a user has with KristScape. Returns a table like {"atenefyr":"redirect.com"}
function getdomains(address) --address is the user's 10-character string, like "kcyd5vejdw"
  local t = explode(";", http.get(base .. "?listnames=" .. address).readAll())
  t[#t] = nil
  local ta = {}
  for i = 1, #t do
    ta[t[i]] = http.get(base .. "?a=" .. t[i]).readAll()
  end
  return ta
end
--Sending money
function give(to, amount, password, isVault) --Be sure to set "isVault" to true if you're using a sha256 hash!
  if not isVault then
    mkey = sha256("KRISTWALLET" .. password)
  else
    mkey = password
  end
  local trans = http.get(base .. "?pushtx2&q=" .. to .. "&pkey=" .. mkey .. "-000&amt=" .. amount).readAll()
  if trans == "Success" then
      return true
  elseif string.sub(trans, 0,5) == "Error" then
    local prob = "Unknown Error"
	  local c = tonumber(string.sub(trans,6,10))
	  if c == 1 then
	    prob = "Insufficient funds"
	  elseif c == 2 then
	    prob = "Not enough KST"
	  elseif c == 3 then
	    prob = "Not perceived as number"
	  elseif c == 4 then
	    prb = "Invalid receiver"
	  end
	  return false, prb
    else
      printError(trans)
    end
end
--Get balance
function balance(address) --Used with miner address, you can do balance(createaddress(password)) if you want to use the password but it will be slow
  local balance = http.get(base .. "?getbalance=" .. address).readAll()
  return balance
end
--Get value of next block
function blockValue()
  local baseblock = http.get(base .. "?getbaseblockvalue").readAll()
  local addon = http.get(base .. "?getdomainaward").readAll()
  local comb = tonumber(baseblock)+tonumber(addon)
  return comb
end

failedLoad = false
