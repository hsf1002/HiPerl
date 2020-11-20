#!/usr/bin/perl

=pod
Perl 是 Practical Extraction and Report Language 的缩写，可翻译为 "实用报表提取语言", 是高级、通用、直译式、动态的程序语言
Perl 具有动态语言的强大灵活的特性，并且还从C/C++、Basic、Pascal等语言中分别借鉴了语法规则 建议的解决方法是在程序里使用use strict;以及use warnings;，并统一代码风格，使用库
Perl 最初的设计者为拉里·沃尔（Larry Wall），于1987年12月18日发表
=cut

use warnings;
use strict;
use Switch;
use POSIX qw(strftime);

print("文件名 ". __FILE__ . "\n");
print("行号 " . __LINE__ ."\n");
print("包名 " . __PACKAGE__ ."\n");

# 输出
print "hello", " sky \n";
print("Hello world \n");

# 转义字符：双中有双，单中有单都需要 \ 转义; 双中有单或单中有双均不需要转义; 双引号可以正常解析一些转义字符与变量，而单引号无法解析会原样输出

# Here文档, $var=<< “EOF” 的意思就是, 下一行开始，直到遇见“EOF”为止, 所有的字符都按照指定的格式存入变量var中. 可以用EEE，MAMA等其他名字
my $var = <<"EOF";
这是一个 Here 文档实例, 可以在这输如字符串和变量
EOF
print "$var \n";

# Perl 是一种弱类型语言，所以变量不需要指定类型，Perl 解释器会根据上下文自动选择匹配类型. 有三个基本的数据类型：标量、数组、哈希
# 标量, 这种数据类型的变量可以是数字，字符串，浮点数，不作严格的区分, 在使用时在变量的名字前面加上一个 $，表示是标量
my $int0 = 123;     #数字123　
my $str0 = "456";   #字符串123　
my $str1 = $int0.$str0;
printf("int0 = %d, str0 = %s \n", $int0, $str0);
printf("str1 = $str1 \n");

# 数组, 以字符 @ 开头，索引从 0 开始; 也可以 qw/.../ 定义数组; 特殊变量 $[ 表示数组的第一索引值，一般都为 0
my @arr0 = (1, 2, 3, 4, 5, 6);
my @arr1 = ("hi", "sky", "hello", "world");
my @arr2 = @arr1;	   # 复制整个数组
my $arr2_size = @arr1; # 获取数组长度
my @arr3 = qw/google taobao pdd/;
my $arr3_size = scalar(@arr3);
printf("arr0 = @arr0, arr0[1] = $arr0[1], size = %d \n", scalar @arr0);
printf("arr2 = @arr2, arr2[1] = $arr2[1], size = %d \n", $arr2_size);
printf("arr3 = @arr3, arr3[-1] = $arr3[-1], size = $arr3_size \n", );

# 哈希, 是一个无序的 key/value 对集合, 可以使用键作为下标获取值, 以字符 % 开头
my %has0 = ('a'=>123,'b'=>456);
my %has1 = ("google", "www.google.com", "baidu", "www.baidu.com", "alibaba", "www.alibaba.com");
my $has0_size = keys %has0;
my $has1_size = values(%has1);
printf("has0_size = $has0_size, has0 = , has0['a'] = $has0{'a'} \n");
printf("has1_size = $has1_size, has1['google'] = $has1{'google'} , has1['baidu'] = $has1{'baidu'} \n");
if( exists($has1{'alibaba'} ) ){
	print "alibaba = $has1{'alibaba'} \n";
}

# v字符串, 面跟着一个或多个用句点分隔的整数,会被当作一个字串文本
my $martin = v77.97.114.116.105.110;
printf("Martin = $martin \n");

# 算术运算符 比较运算符 赋值运算符 位运算 逻辑运算符
# 引号运算符
my $a = 10;
my $b = q{a = $a};	# 单引号
my $c = qq{a = $a};	# 双引号
my $d = qx{date};	# 反引号
printf("a = $a, b = $b, c = $c, d = $d \n");
# 其他运算符
my $aa = "hi"."sky";	# .表示字符串连接
my $bb = "hi" x 3;	# x表示重复次数
my @cc = (7..10);	# .. 表示范围
printf("aa = $aa, bb = $bb, cc = @cc \n");


# 日期，time() 函数：返回从1970年1月1日起累计的秒数; localtime() 函数：获取本地时区时间; gmtime() 函数： 获取格林威治时间
my $loc_datestring = localtime();
my $gmt_datestring = gmtime();
my $fmt_datestring = strftime "%Y-%m-%d %H:%M:%S", localtime;
print "local: ", $loc_datestring, "\n";
print "gmt: ", $gmt_datestring, "\n";
print "format: ", $fmt_datestring, "\n";

my @months = qw( 一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月);
my @days = qw(星期天 星期一 星期二 星期三 星期四 星期五 星期六);
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
my $since = 1900;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
printf "Today: %d, $mday, $months[$mon] $days[$wday] \n", $year + $since;
my $epoc = time();
$epoc = $epoc - 24 * 60 * 60;   # 一天前的时间秒数
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
printf "Yesterday: %d, $mday, $months[$mon] $days[$wday] \n", $year + $since;


open (FILE, "</home/work1/S809_AUR-A0/RESEARCHDOWNLOAD_R19.0.0001/Bin/BMError.ini") or die "can't open $!";
my ($line, $match, $match_size, $match_sub);

while ($line = <FILE>)
{
	$match = "261=";

	if (index($line, $match, 0) != -1)
	{
		$match_size = length($match);
		$match_sub = substr($line, $match_size);
		printf("sub = %s, len = %d \n", $match_sub, $match_size);
	}
}
close FILE;


