= class Struct < Object

include Enumerable

構造体クラス。Struct.new はこのクラスのサブクラスを新たに生成し
ます。個々の構造体はサブクラスから new を使って生成します。個々
の構造体サブクラスでは構造体のメンバに対するアクセスメソッドが定義され
ています。

== Class Methods

--- new([name,] member, ...)

Struct クラスに name という名前の新しいサブクラスを作っ
て、それを返します。サブクラスでは構造体のメンバに対するアクセスメ
ソッドが定義されています。例えば

  dog = Struct.new("Dog", :name, :age)
  fred = dog.new("fred", 5)
  fred.age=6
  printf "name:%s age:%d", fred.name, fred.age

は "name:fred age:6" を出力します。

構造体名 name はStructのクラス定数名になりますので大文字で始
まる必要があります。member は、[[c:Symbol]] か文字列で指定し
ます。

第一引数が文字列の場合、クラス名として扱おうとするため以下のような
指定はエラーになります。したがってメンバは [[c:Symbol]] を指定する
のが無難です

    p Struct.new('foo', 'bar')
    # => -:1:in `new': identifier foo needs to be constant (NameError)

実装の都合により、クラス名の省略は後づけの機能でした。
メンバ名に文字列を指定できるのは後方互換性のためだと考えた方が
良いでしょう

name を省略した場合 (第一引数が [[c:Symbol]] の場合)、
生成した構造体クラスは名前のないクラスとなります。
名前のないクラスは、
最初に名前を求める際に代入されている定数名を検索し、
見つかった定数名をクラス名とします ([[m:Class#Class.new]] を参照)。

例: 構造体クラスのクラス名

    p Struct.new("Foo", :foo, :bar)   # => Struct::Foo

    Foo = Struct.new(:foo, :bar)
    p Foo                             # => Foo

--- new(value, ...)
--- [](value, ...)

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体オブジェクトを生成して返します。
引数は構造体の初期値です。構造体のメンバの数よりも多く指定すると
例外 [[c:ArgumentError]] が発生します。
メンバの初期値は指定されなければ nil です。

例:

    Foo = Struct.new(:foo, :bar)
    foo = Foo.new(1)
    p foo.values      # => [1, nil]

--- members

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体のメンバの名前(文字列)の配列を返します。

例:

    Foo = Struct.new(:foo, :bar)
    p Foo.members      # => ["foo", "bar"]

== Methods

--- [](nth)

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体の nth 番目のメンバの値を返します。nth が文字列
または [[c:Symbol]] の場合はその名前のメンバの値を返します。

存在しないメンバを指定した場合、
nth が整数なら例外 [[c:IndexError]] が発生します。
nth が文字列かシンボルなら例外 [[c:NameError]] が発生します。

    Foo = Struct.new(:foo, :bar)
    obj = Foo.new('FOO', 'BAR')

    p obj[:foo]     # => "FOO"
    p obj['bar']    # => "BAR"
    # p obj[:baz]     # => in `[]': no member 'baz' in struct (NameError)
    p obj[0]        # => "FOO"
    p obj[1]        # => "BAR"
    p obj[-1]       # => "BAR"    # Array のように負のインデックスも指定できます。
    p obj[2]        # => in `[]': offset 2 too large for struct(size:2) (IndexError)

--- []=(nth, value)

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体の nth 番目のメンバの値を value にして value を返します。
nth が文字列または [[c:Symbol]] の場合は
その名前のメンバの値を value にします。

存在しないメンバを指定した場合、
nth が整数なら例外 [[c:IndexError]] が発生します。
nth が文字列かシンボルなら例外 [[c:NameError]] が発生します。

--- each {|value| ... }

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体の各メンバに対して繰り返します。

self を返します。

#@since 1.8.0
--- each_pair {|member, value| ... }

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体のメンバ名([[c:Symbol]])と値の組を引数にブロックを繰り返し実
行します。

self を返します。

    Foo = Struct.new(:foo, :bar)
    Foo.new('FOO', 'BAR').each_pair {|m, v| p [m,v]}

    # => [:foo, "FOO"]
         [:bar, "BAR"]
#@end

--- length
--- size

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体のメンバの数を返します。

--- members

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体のメンバの名前(文字列)の配列を返します。

    Foo = Struct.new(:foo, :bar)
    p Foo.new.members  # => ["foo", "bar"]

--- values
--- to_a

(このメソッドは Struct の下位クラスにのみ定義されています)

構造体のメンバの値を配列にいれて返します。例えば以下のようにして
passwd のエントリ([[unknown:etc]] 参照)を出力できます。

  require 'etc'
  print Etc.getpwuid.values.join(":"), "\n"

#@since 1.8.0
--- values_at(member_1, ... member_n)

(このメソッドは Struct の下位クラスにのみ定義されています)

引数で指定されたメンバ (数値、文字列あるいは [[c:Symbol]])
の値の配列を返します。存在しないメンバを指定した場合は例外
[[c:IndexError]] あるいは [[c:NameError]] が発生します。

    Foo = Struct.new(:foo, :bar, :baz)
    obj = Foo.new('FOO', 'BAR', 'BAZ')

    p obj.values_at(0, :bar, 'baz')    # => ["FOO", "BAR", "BAZ"]
#@end
