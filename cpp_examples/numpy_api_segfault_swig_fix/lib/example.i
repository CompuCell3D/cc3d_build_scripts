%module("threads"=1) example

//%module example

%{
 #include <iostream>
 #include "foo.h"
 #include <numpy/arrayobject.h>
 using namespace std;
%}

//%include "numpy.i"

%init %{
    import_array1(0);
%}


// needed in numpy 1.22 and higher to get PyArray_SimpleNew. any function
// using PyArray_SimpleNew cannot release GIL
// see https://stackoverflow.com/questions/74861186/access-vaiolation-in-pyarray-simplenew
%nothread create_numpy_array_simple_new;

%nothread PocketCalculator::sum;


%include "foo.h"

%inline %{
//    PyObject* create_numpy_array() {
//        // Initialize the NumPy C API
//        cerr<<"create_numpy_array"<<endl;
//
//        cerr<<"create_numpy_array 1"<<endl;
//        int size=3;
//        vector<double> data(size);
//        cerr<<"create_numpy_array 2"<<endl;
//        // Create a NumPy array with the given data
//        npy_intp dims[] = {size};  // Array dimensions
//        PyObject* np_array = PyArray_SimpleNewFromData(1, dims, NPY_DOUBLE, &data[0]);
//        cerr<<"create_numpy_array 3"<<endl;
//
//        return np_array;
//    }
//

    PyObject* create_numpy_array_simple_new() {
        import_array1(0);
        // Initialize the NumPy C API
        cerr<<"create_numpy_array_simple_new"<<endl;

        cerr<<"create_numpy_array 1"<<endl;
    //         int size=3;
    //         vector<float> data(size);
        cerr<<"create_numpy_array 2"<<endl;
        // Create a NumPy array with the given data
        int size=2;
        npy_intp dims[] = {size};  // Array dimensions
        PyObject* np_array = PyArray_SimpleNew(1, dims, NPY_DOUBLE);
        cerr<<"create_numpy_array 3"<<endl;

        return np_array;
    }

%}