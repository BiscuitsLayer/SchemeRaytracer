#pragma once

#include <scheme/scheme.hpp>
#include <error/error.hpp>
#include <catch.hpp>

class SchemeTest {
public:
    void ExpectEq(const std::string& expression, const std::string& result) {
        REQUIRE(scheme_.Evaluate(expression) == result);
    }

    void ExpectNoError(const std::string& expression) {
        scheme_.Evaluate(expression);

        // TODO: implement codegen testing
        // // Interpreter of LLVM IR
        // llvm::outs() << "Running code...\n";

	    // llvm::ExecutionEngine *ee = llvm::EngineBuilder(std::unique_ptr<llvm::Module>(module.get())).create();
        // ee->finalizeObject();

	    //std::vector<llvm::GenericValue> noargs;
	    //llvm::GenericValue res = ee->runFunction(mainFunc, noargs);
	    //llvm::outs() << "Code was run. Result = " << res.IntVal << "\n";
    }

    void ExpectSyntaxError(const std::string& expression) {
        REQUIRE_THROWS_AS(scheme_.Evaluate(expression), SyntaxError);
    }

    void ExpectRuntimeError(const std::string& expression) {
        REQUIRE_THROWS_AS(scheme_.Evaluate(expression), RuntimeError);
    }

    void ExpectNameError(const std::string& expression) {
        REQUIRE_THROWS_AS(scheme_.Evaluate(expression), NameError);
    }

private:
    Scheme::Scheme scheme_;
};
