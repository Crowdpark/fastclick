/**
 * Created with JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 7/5/12
 * Time: 10:40 AM
 * To change this template use File | Settings | File Templates.
 */
function (doc) {
    if (doc._id.substr(0, 15) === "FacebookUserMvo") {

        emit(doc._id.substring(16), [doc.first_name, doc.last_name]);

    }
}