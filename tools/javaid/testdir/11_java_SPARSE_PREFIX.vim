if exists("g:java_highlight_all") || exists("g:java_highlight_java")
  " java
  hi def link javaC_Java javaC_
  hi def link javaI_Java javaI_
  hi def link javaX_Java javaX_
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_awt")
  " java.awt
  hi def link javaC_JavaAwt javaC_Java
  hi def link javaI_JavaAwt javaI_Java
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_awt") || exists("g:java_highlight_java_awt_dnd")
  " java.awt.dnd
  hi def link javaI_JavaAwtDnd javaI_JavaAwt
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_awt") || exists("g:java_highlight_java_awt_dnd") || exists("g:java_highlight_java_awt_dnd_peer")
  " java.desktop/java.awt.dnd.peer
  syn keyword javaI_JavaAwtDndPeer DragSourceContextPeer DropTargetContextPeer DropTargetPeer
  syn cluster javaClasses add=javaI_JavaAwtDndPeer
  hi def link javaI_JavaAwtDndPeer javaI_JavaAwtDnd
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_awt") || exists("g:java_highlight_java_awt_im")
  " java.awt.im
  hi def link javaI_JavaAwtIm javaI_JavaAwt
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_awt") || exists("g:java_highlight_java_awt_im") || exists("g:java_highlight_java_awt_im_spi")
  " java.desktop/java.awt.im.spi
  syn keyword javaI_JavaAwtImSpi InputMethod InputMethodContext InputMethodDescriptor
  syn cluster javaClasses add=javaI_JavaAwtImSpi
  hi def link javaI_JavaAwtImSpi javaI_JavaAwtIm
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_awt") || exists("g:java_highlight_java_awt_image")
  " java.awt.image
  hi def link javaC_JavaAwtImage javaC_JavaAwt
  hi def link javaI_JavaAwtImage javaI_JavaAwt
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_awt") || exists("g:java_highlight_java_awt_image") || exists("g:java_highlight_java_awt_image_renderable")
  " java.desktop/java.awt.image.renderable
  syn keyword javaC_JavaAwtImageRenderable ParameterBlock RenderContext RenderableImageOp RenderableImageProducer
  syn cluster javaClasses add=javaC_JavaAwtImageRenderable
  hi def link javaC_JavaAwtImageRenderable javaC_JavaAwtImage
  syn keyword javaI_JavaAwtImageRenderable ContextualRenderedImageFactory RenderableImage RenderedImageFactory
  syn cluster javaClasses add=javaI_JavaAwtImageRenderable
  hi def link javaI_JavaAwtImageRenderable javaI_JavaAwtImage
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio")
  " java.nio
  hi def link javaC_JavaNio javaC_Java
  hi def link javaI_JavaNio javaI_Java
  hi def link javaX_JavaNio javaX_Java
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio") || exists("g:java_highlight_java_nio_channels")
  " java.nio.channels
  hi def link javaC_JavaNioChannels javaC_JavaNio
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio") || exists("g:java_highlight_java_nio_channels") || exists("g:java_highlight_java_nio_channels_spi")
  " java.base/java.nio.channels.spi
  syn keyword javaC_JavaNioChannelsSpi AbstractInterruptibleChannel AbstractSelectableChannel AbstractSelectionKey AbstractSelector AsynchronousChannelProvider SelectorProvider
  syn cluster javaClasses add=javaC_JavaNioChannelsSpi
  hi def link javaC_JavaNioChannelsSpi javaC_JavaNioChannels
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio") || exists("g:java_highlight_java_nio_charset")
  " java.nio.charset
  hi def link javaC_JavaNioCharset javaC_JavaNio
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio") || exists("g:java_highlight_java_nio_charset") || exists("g:java_highlight_java_nio_charset_spi")
  " java.base/java.nio.charset.spi
  syn keyword javaC_JavaNioCharsetSpi CharsetProvider
  syn cluster javaClasses add=javaC_JavaNioCharsetSpi
  hi def link javaC_JavaNioCharsetSpi javaC_JavaNioCharset
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio") || exists("g:java_highlight_java_nio_file")
  " java.nio.file
  hi def link javaC_JavaNioFile javaC_JavaNio
  hi def link javaI_JavaNioFile javaI_JavaNio
  hi def link javaX_JavaNioFile javaX_JavaNio
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio") || exists("g:java_highlight_java_nio_file") || exists("g:java_highlight_java_nio_file_attribute")
  " java.base/java.nio.file.attribute
  syn keyword javaC_JavaNioFileAttribute AclEntry AclEntryFlag AclEntryPermission AclEntryType Builder FileTime PosixFilePermission PosixFilePermissions UserPrincipalLookupService
  syn cluster javaClasses add=javaC_JavaNioFileAttribute
  hi def link javaC_JavaNioFileAttribute javaC_JavaNioFile
  syn keyword javaI_JavaNioFileAttribute AclFileAttributeView AttributeView BasicFileAttributeView BasicFileAttributes DosFileAttributeView DosFileAttributes FileAttributeView FileOwnerAttributeView FileStoreAttributeView GroupPrincipal PosixFileAttributeView PosixFileAttributes UserDefinedFileAttributeView UserPrincipal
  syn cluster javaClasses add=javaI_JavaNioFileAttribute
  hi def link javaI_JavaNioFileAttribute javaI_JavaNioFile
  syn keyword javaX_JavaNioFileAttribute UserPrincipalNotFoundException
  syn cluster javaClasses add=javaX_JavaNioFileAttribute
  hi def link javaX_JavaNioFileAttribute javaX_JavaNioFile

  if !exists("g:java_highlight_generics")
    syn keyword javaI_JavaNioFileAttribute FileAttribute
    syn cluster javaClasses add=javaI_JavaNioFileAttribute
    hi def link javaI_JavaNioFileAttribute javaI_JavaNioFile
  endif

endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_nio") || exists("g:java_highlight_java_nio_file") || exists("g:java_highlight_java_nio_file_spi")
  " java.base/java.nio.file.spi
  syn keyword javaC_JavaNioFileSpi FileSystemProvider FileTypeDetector
  syn cluster javaClasses add=javaC_JavaNioFileSpi
  hi def link javaC_JavaNioFileSpi javaC_JavaNioFile
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_util")
  " java.util
  hi def link javaC_JavaUtil javaC_Java
  hi def link javaI_JavaUtil javaI_Java
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_util") || exists("g:java_highlight_java_util_concurrent")
  " java.util.concurrent
  hi def link javaC_JavaUtilConcurrent javaC_JavaUtil
  hi def link javaI_JavaUtilConcurrent javaI_JavaUtil
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_util") || exists("g:java_highlight_java_util_concurrent") || exists("g:java_highlight_java_util_concurrent_atomic")
  " java.base/java.util.concurrent.atomic
  syn keyword javaC_JavaUtilConcurrentAtomic AtomicBoolean AtomicInteger AtomicIntegerArray AtomicLong AtomicLongArray DoubleAccumulator DoubleAdder LongAccumulator LongAdder
  syn cluster javaClasses add=javaC_JavaUtilConcurrentAtomic
  hi def link javaC_JavaUtilConcurrentAtomic javaC_JavaUtilConcurrent

  if !exists("g:java_highlight_generics")
    syn keyword javaC_JavaUtilConcurrentAtomic AtomicIntegerFieldUpdater AtomicLongFieldUpdater AtomicMarkableReference AtomicReference AtomicReferenceArray AtomicReferenceFieldUpdater AtomicStampedReference
    syn cluster javaClasses add=javaC_JavaUtilConcurrentAtomic
    hi def link javaC_JavaUtilConcurrentAtomic javaC_JavaUtilConcurrent
  endif

endif

if exists("g:java_highlight_all") || exists("g:java_highlight_java") || exists("g:java_highlight_java_util") || exists("g:java_highlight_java_util_concurrent") || exists("g:java_highlight_java_util_concurrent_locks")
  " java.base/java.util.concurrent.locks
  syn keyword javaC_JavaUtilConcurrentLocks AbstractOwnableSynchronizer AbstractQueuedLongSynchronizer AbstractQueuedSynchronizer ConditionObject LockSupport ReadLock ReentrantLock ReentrantReadWriteLock StampedLock WriteLock
  syn cluster javaClasses add=javaC_JavaUtilConcurrentLocks
  hi def link javaC_JavaUtilConcurrentLocks javaC_JavaUtilConcurrent
  syn keyword javaI_JavaUtilConcurrentLocks Condition Lock ReadWriteLock
  syn cluster javaClasses add=javaI_JavaUtilConcurrentLocks
  hi def link javaI_JavaUtilConcurrentLocks javaI_JavaUtilConcurrent
endif

