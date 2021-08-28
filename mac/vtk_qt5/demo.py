import os.path
import ctypes
import ctypes.util
from ctypes import *

me = os.path.abspath(os.path.dirname(__file__))
# lib = cdll.LoadLibrary(os.path.join(me, "..", "libtest.so"))
lib = cdll.LoadLibrary(ctypes.util.find_library('libcpposxhelper'))

# func = lib.test_get_data_nulls
# func.restype = POINTER(c_char)
# func.argtypes = [POINTER(c_int)]
#
# l = c_int()
# data = func(byref(l))
#
# print data,l,data.contents
#
# # lib.cpp_print_hello(l)
#
#
# lib.test_data_print(data,l)
# lib.test_data_print_1(l)
lib.test_data_print_2()
lib.cpp_print_hello_1()
lib.cpp_print_hello()

l_int = c_long(12)
lib.cpp_print_hello_long(l_int)
l_int_1 = c_long(326951217)
lib.cpp_print_hello_long(l_int_1)
l_int_2 = c_long(3269512170)
lib.cpp_print_hello_long(l_int_2)


# import os.path
# from ctypes import *
# import ctypes.util
#
# me = os.path.abspath(os.path.dirname(__file__))
# lib = cdll.LoadLibrary(ctypes.util.find_library('libcpposxhelper'))
#
# func = lib.cpp_print_hello
# print func
# # func.restype = None
# # func.argtypes = POINTER(c_int)
# l = c_int()
# func(l)
# func.restype = POINTER(c_char)
# func.argtypes = [POINTER(c_int)]
#
#
# import PyQt5
# import vtk
#
# import ctypes
# import ctypes.util
#
# cpposxhelper = ctypes.cdll.LoadLibrary(ctypes.util.find_library('libcpposxhelper'))
# print 'cpposxhelper=',cpposxhelper
# # print_hello = cpposxhelper.cpp_print_hello()
# # print 'hello=',print_hello


# # Need to do this to load the NSSpeechSynthesizer class, which is in AppKit.framework
# appkit = ctypes.cdll.LoadLibrary(ctypes.util.find_library('AppKit'))
# objc = ctypes.cdll.LoadLibrary(ctypes.util.find_library('objc'))
# cocoa = ctypes.cdll.LoadLibrary(ctypes.util.find_library('cocoa'))
#
# objc.objc_getClass.restype = ctypes.c_void_p
# objc.sel_registerName.restype = ctypes.c_void_p
# objc.objc_msgSend.restype = ctypes.c_void_p
# objc.objc_msgSend.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
#
#
# Cocoa = ctypes.cdll.LoadLibrary(ctypes.util.find_library('Cocoa'))
# print cocoa
# print Cocoa
#
#
# NSView = cocoa.objc_getClass('NSView')
#
# NSAutoreleasePool = objc.objc_getClass('NSAutoreleasePool')
# print 'NSAutoreleasePool=',NSAutoreleasePool
# print NSView
#
# osxhelper = ctypes.cdll.LoadLibrary(ctypes.util.find_library('osxhelper'))
#
# cpposxhelper = ctypes.cdll.LoadLibrary(ctypes.util.find_library('cpposxhelper'))
#
# print osxhelper
#
# NSSpeechSynthesizer = objc.objc_getClass('NSSpeechSynthesizer')
# availableVoices = objc.objc_msgSend(NSSpeechSynthesizer, objc.sel_registerName('availableVoices'))
#
# count = objc.objc_msgSend(availableVoices, objc.sel_registerName('count'))
# print count
#
# print_hello = cpposxhelper.cpp_print_hello()
#
# # objc.objc_msgSend(print_hello, objc.sel_registerName(''))



