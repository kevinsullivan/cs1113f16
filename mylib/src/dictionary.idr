||| Implements a dictionary abstract data type
module dictionary

import list
import pair
import public option
import ifthenelse

||| A dictionary data type with a private implemented
export
data Dictionary k v = MkDictionary (List (Pair k v))


||| A public function to build and return an empty dictionary
export
dictionary_new: Dictionary k v
dictionary_new = MkDictionary Nil


||| Function to insert (k, v) into dictionary. If there was no
||| previous value for k in the dictionary, v will now be that
||| value. If there was already a value for k, v will be the new
||| value for k. In other words, dictionary_insert "overwrites"
||| any previous definition.
export
dictionary_insert: Dictionary k v -> Pair k v -> Dictionary k v
{-
We implement insert in a very straightforward way: We just add
the given pair as the head of the existing list. When we do a
lookup, we will search down the list and return the value (as
an option) for the first pair that matches the given key. that
is our implementation strategy.
-}
dictionary_insert (MkDictionary l) p =
  MkDictionary (Cons p l)

||| A private helper function in support of dictionary_lookup.
dict_list_lookup: Eq k => List (Pair k v) -> k -> Option v
dict_list_lookup Nil k = None
dict_list_lookup (Cons h t) k =
  ifthenelse
    (eq k (pair_key h))
    (Some (pair_value h))
    (dict_list_lookup t k)

||| Function to look up and return the value for a given key if
||| there is one. This function requires the ability to decide
||| whether the given key, k, is equal to keys in the dictionary;
||| therefore, as with list_eq, we need to constrain the key type
||| to be a type for which "eq" is defined, i.e., to be a type for
||| which there is an implementation of the "Eq" interface.
export
dictionary_lookup: Eq k => (dict: Dictionary k v) -> (key: k) -> Option v
dictionary_lookup (MkDictionary l) k = dict_list_lookup l k
