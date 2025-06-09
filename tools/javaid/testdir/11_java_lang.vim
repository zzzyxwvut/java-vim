if exists("g:java_highlight_all") || exists("g:java_highlight_java")
  " java
  hi def link javaC_Java javaC_
  hi def link javaE_Java javaE_
  hi def link javaI_Java javaI_
  hi def link javaR_Java javaR_
  hi def link javaX_Java javaX_
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_lang")
  " java.base/java.lang
  syn match   javaC_JavaLang "\<Class\>"
  syn match   javaC_JavaLang "\<ClassValue\>"
  syn match   javaC_JavaLang "\<Enum\>"
  syn match   javaC_JavaLang "\<InheritableThreadLocal\>"
  syn match   javaC_JavaLang "\<ThreadLocal\>"
  syn keyword javaC_JavaLang Boolean Byte Character ClassLoader Compiler Controller Double Float Integer Level LoggerFinder Long Math Module ModuleLayer Number Object Option Package Process ProcessBuilder Redirect Runtime RuntimePermission SecurityManager Short StackTraceElement StackWalker State StrictMath String StringBuffer StringBuilder Subset System Thread ThreadGroup Throwable Type UnicodeBlock UnicodeScript Version Void
  syn cluster javaClasses add=javaC_JavaLang
  hi def link javaC_JavaLang javaC_Java
  syn keyword javaE_JavaLang AbstractMethodError AssertionError BootstrapMethodError ClassCircularityError ClassFormatError Error ExceptionInInitializerError IllegalAccessError IncompatibleClassChangeError InstantiationError InternalError LinkageError NoClassDefFoundError NoSuchFieldError NoSuchMethodError OutOfMemoryError StackOverflowError ThreadDeath UnknownError UnsatisfiedLinkError UnsupportedClassVersionError VerifyError VirtualMachineError
  syn cluster javaClasses add=javaE_JavaLang
  hi def link javaE_JavaLang javaE_Java
  syn match   javaI_JavaLang "\<Comparable\>"
  syn match   javaI_JavaLang "\<Iterable\>"
  syn keyword javaI_JavaLang Appendable AutoCloseable CharSequence Cloneable Deprecated FunctionalInterface Info Logger Override ProcessHandle Readable Runnable SafeVarargs StackFrame SuppressWarnings UncaughtExceptionHandler
  syn cluster javaClasses add=javaI_JavaLang
  hi def link javaI_JavaLang javaI_Java
  syn keyword javaR_JavaLang ArithmeticException ArrayIndexOutOfBoundsException ArrayStoreException ClassCastException EnumConstantNotPresentException IllegalArgumentException IllegalCallerException IllegalMonitorStateException IllegalStateException IllegalThreadStateException IndexOutOfBoundsException LayerInstantiationException NegativeArraySizeException NullPointerException NumberFormatException RuntimeException SecurityException StringIndexOutOfBoundsException TypeNotPresentException UnsupportedOperationException
  syn cluster javaClasses add=javaR_JavaLang
  hi def link javaR_JavaLang javaR_Java
  syn keyword javaX_JavaLang ClassNotFoundException CloneNotSupportedException Exception IllegalAccessException InstantiationException InterruptedException NoSuchFieldException NoSuchMethodException ReflectiveOperationException
  syn cluster javaClasses add=javaX_JavaLang
  hi def link javaX_JavaLang javaX_Java
endif

