# LDFLAGS is modified from `llvm-config --libs`
# -- certain libs were not found for some reason or another...
LDFLAGS=-lclangFrontend \
		-lclangDriver \
		-lclangSerialization \
		-lclangParse \
		-lclangSema \
		-lclangAnalysis \
		-lclangRewrite \
		-lclangEdit \
		-lclangAST \
		-lclangLex \
		-lclangBasic \
		-lLLVMAsmParser \
		-lLLVMInstrumentation \
		-lLLVMLinker \
		-lLLVMArchive \
		-lLLVMBitReader \
		-lLLVMDebugInfo \
		-lLLVMJIT \
		-lLLVMipo \
		-lLLVMVectorize \
		-lLLVMBitWriter \
		-lLLVMTableGen \
		-lLLVMHexagonCodeGen \
		-lLLVMHexagonDesc \
		-lLLVMHexagonInfo \
		-lLLVMHexagonAsmPrinter \
		-lLLVMMBlazeDisassembler \
		-lLLVMMBlazeAsmParser \
		-lLLVMMBlazeCodeGen \
		-lLLVMMBlazeDesc \
		-lLLVMMBlazeInfo \
		-lLLVMMBlazeAsmPrinter \
		-lLLVMCppBackendCodeGen \
		-lLLVMCppBackendInfo \
		-lLLVMMSP430CodeGen \
		-lLLVMMSP430Desc \
		-lLLVMMSP430Info \
		-lLLVMMSP430AsmPrinter \
		-lLLVMXCoreCodeGen \
		-lLLVMXCoreDesc \
		-lLLVMXCoreInfo \
		-lLLVMCellSPUCodeGen \
		-lLLVMCellSPUDesc \
		-lLLVMCellSPUInfo \
		-lLLVMMipsCodeGen \
		-lLLVMMipsAsmParser \
		-lLLVMMipsDisassembler \
		-lLLVMMipsDesc \
		-lLLVMMipsInfo \
		-lLLVMMipsAsmPrinter \
		-lLLVMARMDisassembler \
		-lLLVMARMAsmParser \
		-lLLVMARMCodeGen \
		-lLLVMARMDesc \
		-lLLVMARMInfo \
		-lLLVMARMAsmPrinter \
		-lLLVMPowerPCCodeGen \
		-lLLVMPowerPCDesc \
		-lLLVMPowerPCInfo \
		-lLLVMPowerPCAsmPrinter \
		-lLLVMSparcCodeGen \
		-lLLVMSparcDesc \
		-lLLVMSparcInfo \
		-lLLVMX86AsmParser \
		-lLLVMX86Disassembler \
		-lLLVMX86CodeGen \
		-lLLVMSelectionDAG \
		-lLLVMAsmPrinter \
		-lLLVMX86Desc \
		-lLLVMX86Info \
		-lLLVMX86AsmPrinter \
		-lLLVMX86Utils \
		-lgtest_main \
		-lgtest \
		-lLLVMMCDisassembler \
		-lLLVMMCParser \
		-lLLVMInterpreter \
		-lLLVMCodeGen \
		-lLLVMScalarOpts \
		-lLLVMInstCombine \
		-lLLVMTransformUtils \
		-lLLVMipa \
		-lLLVMAnalysis \
		-lLLVMMCJIT \
		-lLLVMRuntimeDyld \
		-lLLVMExecutionEngine \
		-lLLVMTarget \
		-lLLVMMC \
		-lLLVMObject \
		-lLLVMCore \
		-lLLVMSupport

CLANGFLAGS=`../build/Debug+Asserts/bin/llvm-config --cxxflags --ldflags`

CFLAGS=-L ../build/Debug+Asserts/lib \
		-I`../build/Debug+Asserts/bin/llvm-config --includedir` \
		-I ../llvm/tools/clang/include \
		-I ../build/include \
		-I ../build/tools/clang/include

SCAFFOLD=scaffold

all: Sqct Clang

Clang:
	@mkdir -p build
	@cd llvm/tools && /bin/rm -f clang && /bin/ln -s ../../clang;
	@cd clang && /bin/rm -f build && /bin/ln -s ../build;
	@cd build && cmake ../llvm/ && make ;
	@if [ -z `echo ${PATH} | grep ${PWD}/Debug+Asserts/bin` ]; then \
		export PATH=${PATH}:${PWD}/Debug+Asserts/bin; \
	else true; fi
	@if [ -z `echo ${PATH} | grep ${PWD}/Debug+Asserts/bin` ]; then \
		export PATH=${PATH}:${PWD}/Debug+Asserts/bin; \
	else true; fi

Scaffold:
	@cd scaffold && make;

Sqct:
ifdef DISABLE_STATIC
	@cd Rotations/sqct && make DISABLE_STATIC=1
else
	@cd Rotations/sqct && make
endif

clean:
	@cd Rotations/sqct && make clean
	@if [ -d build ]; then cd build && make clean; fi

.PHONY: clean Sqct Scaffold Clang
