#pragma once

#include <optional>
#include <cstdint>

#include <helpers/helpers.hpp>
#include <scope/scope.hpp>
#include <object/object.hpp>

namespace Interp {

ObjectPtr BuildLambda(std::optional<std::string> name, ObjectPtr init, ScopePtr scope);
std::pair<std::string, ObjectPtr> BuildLambdaSugar(std::vector<ObjectPtr> parts, ScopePtr scope);

} // namespace Interp

namespace Codegen {

ObjectPtr BuildLambdaCodegen(std::optional<std::string> name, ObjectPtr init, ScopePtr scope);
std::pair<std::string, ObjectPtr> BuildLambdaSugarCodegen(std::vector<ObjectPtr> parts, ScopePtr scope);

} // namespace Codegen