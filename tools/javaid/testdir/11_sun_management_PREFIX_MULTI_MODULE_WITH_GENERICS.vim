if exists("g:java_highlight_all") || exists("g:java_highlight_sun")
  " sun
  hi def link javaC_Sun javaC_
  hi def link javaI_Sun javaI_
  hi def link javaR_Sun javaR_
  hi def link javaX_Sun javaX_
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_sun") || exists("g:java_highlight_sun_management")
  " java.management/sun.management
  syn keyword javaC_SunManagement BaseOperatingSystemImpl CompilerThreadStat GarbageCollectorImpl HotspotInternal LazyCompositeData LockInfoCompositeData ManagementFactoryHelper MappedMXBeanType MemoryNotifInfoCompositeData MemoryUsageCompositeData MethodInfo MonitorInfoCompositeData NotificationEmitterSupport Sensor StackTraceElementCompositeData ThreadImpl ThreadInfoCompositeData Util
  syn cluster javaClasses add=javaC_SunManagement
  hi def link javaC_SunManagement javaC_Sun
  syn keyword javaI_SunManagement HotspotClassLoadingMBean HotspotCompilationMBean HotspotInternalMBean HotspotMemoryMBean HotspotRuntimeMBean HotspotThreadMBean VMManagement
  syn cluster javaClasses add=javaI_SunManagement
  hi def link javaI_SunManagement javaI_Sun
  hi def link javaR_SunManagement javaR_Sun
  hi def link javaX_SunManagement javaX_Sun
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_sun") || exists("g:java_highlight_sun_management") || exists("g:java_highlight_sun_management_counter")
  " java.management/sun.management.counter
  syn keyword javaC_SunManagementCounter AbstractCounter Units Variability
  syn cluster javaClasses add=javaC_SunManagementCounter
  hi def link javaC_SunManagementCounter javaC_SunManagement
  syn keyword javaI_SunManagementCounter ByteArrayCounter Counter LongArrayCounter LongCounter StringCounter
  syn cluster javaClasses add=javaI_SunManagementCounter
  hi def link javaI_SunManagementCounter javaI_SunManagement
  hi def link javaR_SunManagementCounter javaR_SunManagement
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_sun") || exists("g:java_highlight_sun_management") || exists("g:java_highlight_sun_management_counter") || exists("g:java_highlight_sun_management_counter_perf")
  " java.management/sun.management.counter.perf
  syn keyword javaC_SunManagementCounterPerf PerfByteArrayCounter PerfInstrumentation PerfLongArrayCounter PerfLongCounter PerfStringCounter
  syn cluster javaClasses add=javaC_SunManagementCounterPerf
  hi def link javaC_SunManagementCounterPerf javaC_SunManagementCounter
  syn keyword javaR_SunManagementCounterPerf InstrumentationException
  syn cluster javaClasses add=javaR_SunManagementCounterPerf
  hi def link javaR_SunManagementCounterPerf javaR_SunManagementCounter
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_sun") || exists("g:java_highlight_sun_management") || exists("g:java_highlight_sun_management_jdp")
  " jdk.management.agent/sun.management.jdp
  syn keyword javaC_SunManagementJdp JdpBroadcaster JdpController JdpGenericPacket JdpJmxPacket JdpPacketReader JdpPacketWriter
  syn cluster javaClasses add=javaC_SunManagementJdp
  hi def link javaC_SunManagementJdp javaC_SunManagement
  syn keyword javaI_SunManagementJdp JdpPacket
  syn cluster javaClasses add=javaI_SunManagementJdp
  hi def link javaI_SunManagementJdp javaI_SunManagement
  syn keyword javaX_SunManagementJdp JdpException
  syn cluster javaClasses add=javaX_SunManagementJdp
  hi def link javaX_SunManagementJdp javaX_SunManagement
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_sun") || exists("g:java_highlight_sun_management") || exists("g:java_highlight_sun_management_jmxremote")
  " jdk.management.agent/sun.management.jmxremote
  syn keyword javaC_SunManagementJmxremote ConnectorBootstrap LocalRMIServerSocketFactory SingleEntryRegistry
  syn cluster javaClasses add=javaC_SunManagementJmxremote
  hi def link javaC_SunManagementJmxremote javaC_SunManagement
  syn keyword javaI_SunManagementJmxremote DefaultValues PropertyNames
  syn cluster javaClasses add=javaI_SunManagementJmxremote
  hi def link javaI_SunManagementJmxremote javaI_SunManagement
endif

if exists("g:java_highlight_all") || exists("g:java_highlight_sun") || exists("g:java_highlight_sun_management") || exists("g:java_highlight_sun_management_spi")
  " java.management/sun.management.spi
  syn keyword javaC_SunManagementSpi PlatformMBeanProvider
  syn cluster javaClasses add=javaC_SunManagementSpi
  hi def link javaC_SunManagementSpi javaC_SunManagement
  syn match   javaI_SunManagementSpi "\<PlatformComponent\>"
  syn cluster javaClasses add=javaI_SunManagementSpi
  hi def link javaI_SunManagementSpi javaI_SunManagement
endif

