
.class public Variables
.super java/lang/Object

.method public <init>()V
  aload_0
  invokenonvirtual java/lang/Object/<init>()V
  return
.end method

.method public static main([Ljava/lang/String;)V
  .limit stack 10
  .limit locals 10

  ; V[1] = 123
  bipush 123
  istore 1

  ; System.out.println(V[1])
  getstatic java/lang/System/out Ljava/io/PrintStream;
  iload 1
  invokevirtual java/io/PrintStream/println(I)V

  ; System.out.println("V[1]+321 = " + (V[1] + 321))
  getstatic java/lang/System/out Ljava/io/PrintStream;
  ldc "V[1]+321 = "
  invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V

  getstatic java/lang/System/out Ljava/io/PrintStream;
  iload 1
  ldc 321
  iadd
  invokevirtual java/io/PrintStream/println(I)V

  return
.end method
