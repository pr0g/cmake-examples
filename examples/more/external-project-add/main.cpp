#include <iostream>

// rapidjson 
#include "rapidjson/document.h"
#include "rapidjson/writer.h"
#include "rapidjson/stringbuffer.h"
// rapidjson

// restbed
#include <memory>
#include <cstdlib>
#include <restbed>

using namespace std;
using namespace restbed;
// restbed



// rapidjson
void test_rapidjson() {
    using namespace rapidjson;
    
    // 1. Parse a JSON string into DOM.
    const char* json = "{\"project\":\"rapidjson\",\"stars\":10}";
    Document d;
    d.Parse(json);

    // 2. Modify it by DOM.
    Value& s = d["stars"];
    s.SetInt(s.GetInt() + 1);

    // 3. Stringify the DOM
    StringBuffer buffer;
    Writer<StringBuffer> writer(buffer);
    d.Accept(writer);

    // Output {"project":"rapidjson","stars":11}
    std::cout << buffer.GetString() << std::endl;
}
// rapidjson
// restbed
void post_method_handler( const shared_ptr< Session > session )
{
    const auto request = session->get_request( );

    size_t content_length = request->get_header( "Content-Length", 0 );

    session->fetch( content_length, [ request ]( const shared_ptr< Session > session, const Bytes & body )
    {
        fprintf( stdout, "%.*s\n", ( int ) body.size( ), body.data( ) );
        session->close( OK, "Hello, World!", { { "Content-Length", "13" }, { "Connection", "close" } } );
    } );
}

int test_restbed( )
{
    auto resource = make_shared< Resource >( );
    resource->set_path( "/resource" );
    resource->set_method_handler( "POST", post_method_handler );

    Service service;
    service.publish( resource );
    service.start( );

    return EXIT_SUCCESS;
}
// restbed

// simple example program using bitfield-enum-class library
int main(int argc, char** argv) {
    
    test_restbed();
    test_rapidjson();
    
    return 0;
}
